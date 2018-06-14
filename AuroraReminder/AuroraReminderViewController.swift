//
//  ViewController.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/10/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import UIKit

class AuroraReminderViewController: UITableViewController {

    let items = ["first", "second", "third"]
    
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
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
}

