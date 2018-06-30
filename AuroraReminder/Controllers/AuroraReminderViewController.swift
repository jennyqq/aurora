//
//  ViewController.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/10/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class AuroraReminderViewController: SwipeViewController, UISearchBarDelegate {
    
    let realm = try! Realm()
    
    var items : Results<Item>!
 
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
   
    override func viewDidLoad() {
        loadItems()
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
     }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.value
        cell.accessoryType = item.done ? .checkmark : .none
        
        cell.backgroundColor = FlatWhite().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(items.count))
        
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        let item = items[indexPath.row]
        
        do {
            try self.realm.write {
                item.done = !item.done
            }
        } catch {
            print ("error \(error)")
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = item.done ? .checkmark : .none
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "value", ascending: true)
    }
    
    override func deleteCell(indexPath: IndexPath) {
        
        let item = self.items[indexPath.row];
        
        do {
            try self.realm.write {
                 realm.delete(item)
            }
        } catch {
            print ("error \(error)")
        }
        
    }
   
    
    //MARK: add reminder
    
    @IBAction func addReminder(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add reminder", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (text) in
            text.placeholder = "Please enter new item"
            textField = text
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action)
            in
           
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let item = Item()
                        item.value = textField.text!
                        item.done = false
                        currentCategory.items.append(item)
                    }
                } catch {
                    print ("error \(error)")
                }
            }
           self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        items = items.filter("value CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "value", ascending: true)
//        print(items)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}


