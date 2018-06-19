//
//  ViewController.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/10/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import UIKit

class AuroraReminderViewController: UITableViewController {

    var items = ["first", "second", "third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (items[indexPath.row])
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
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
           
            self.items.append(textField.text!)
            
            self.tableView.reloadData()
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

