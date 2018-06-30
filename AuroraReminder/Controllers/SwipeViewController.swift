//
//  SwipeViewController.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/28/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import Foundation
import SwipeCellKit

class SwipeViewController : UITableViewController, SwipeTableViewCellDelegate, SwipeViewDeleteAction {
    override func viewDidLoad() {
        tableView.rowHeight = 80
    }
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        options.expansionStyle = .destructive
//        return options
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.deleteCell(indexPath: indexPath)
 
            self.tableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func deleteCell(indexPath: IndexPath) {
        //donothing
    }
}

protocol SwipeViewDeleteAction {
    func deleteCell(indexPath: IndexPath)
}
