//
//  ViewController.swift
//  Todoey
//
//  Created by Narongsak_O on 28/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {
    
    let itemArray = ["Find mike","Buy Eggs","Destro Demogorous"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK - TableView Datasource Methods
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new ITEM
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        let alert = UIAlertController(title: "Add new Todoay item ", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happend once the user click Add Item button on UI button
            print("Success!")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

