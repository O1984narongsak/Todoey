//
//  AppDelegate.swift
//  Todoey
//
//  Created by Narongsak_O on 28/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error initialising new realm,\(error)")
        }
        
       
        
        return true
    }

}

