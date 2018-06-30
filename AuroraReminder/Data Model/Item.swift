//
//  Item.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/19/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var value: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
