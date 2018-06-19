//
//  ViewController.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/10/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import UIKit

class AuroraReminderViewController: UITableViewController {

    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let total = 16
        items = [Item]()
        
        for i in 0...total {
            let item = Item()
            item.value = String(i)
            items.append(item)
        }
 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.value
        cell.accessoryType = item.done ? .checkmark : .none
        
        
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
        
        item.done = !item.done
        
        tableView.cellForRow(at: indexPath)?.accessoryType = item.done ? .checkmark : .none
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK add reminder
    
    @IBAction func addReminder(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add reminder", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (text) in
            text.placeholder = "Please enter new item"
            
            textField = text
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
           
            let item = Item()
            item.value = textField.text!
            item.done = false;
            
            self.items.append(item)
            
            self.tableView.reloadData()
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

