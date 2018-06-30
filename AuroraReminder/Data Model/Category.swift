//
//  Category.swift
//  AuroraReminder
//
//  Created by Qiu Zhang on 6/21/18.
//  Copyright © 2018 Qiu Zhang. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
