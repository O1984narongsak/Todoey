//
//  Item.swift
//  Todoey
//
//  Created by Narongsak_O on 31/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @onjc dynamic var done : Bool = false
    var parentCategory = LinkingObject(fromType: Catagory.self, property: "items")
    
}
