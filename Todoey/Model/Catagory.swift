//
//  Catagory.swift
//  Todoey
//
//  Created by Narongsak_O on 31/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import Foundation
import RealmSwift

class Catagory: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
