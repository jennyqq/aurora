//
//  Category.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/21/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework


class AuroraCategoryViewController: SwipeViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>!
    
    override func viewDidLoad() {
       loadCategories()
       tableView.rowHeight = 80
       tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.backgroundColor = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row)/CGFloat(categories.count))
        
        cell.textLabel?.text = category.name
        
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
     
        return cell
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    //MARK: - Data Saving Method
    func save(category: Category) {
        
        do {
            try realm.write {
                self.realm.add(category)
            }
        } catch {
            print ("Error init value \(error)")
        }
        
    }
    
    //MARK: - Data Deleting Method
    func deleteCategory(category: Category) {
        
        do {
            try realm.write {
                self.realm.delete(category)
            }
        } catch {
            print ("Error init value \(error)")
        }
        
    }
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (text) in
            
            text.placeholder = "Please enter new Category"
            
            textField = text
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let category = Category()
            
            category.name = textField.text!
            
            self.save(category: category)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AuroraReminderViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destVC.selectedCategory = self.categories[indexPath.row]
        }
    }
    
    override func deleteCell(indexPath: IndexPath) {
        
        let category = self.categories[indexPath.row];
    
        self.deleteCategory(category: category);
        
        loadCategories()
        
    }
}

