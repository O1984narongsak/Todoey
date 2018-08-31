//
//  ViewController.swift
//  Todoey
//
//  Created by Narongsak_O on 28/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import RealmSwift

class TodoeyViewController: UITableViewController {
    
    var todoItem : Results<Item>?
    
    let ream = try! Realm()
    
    var selectedCatagory : Catagory? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }

//MARK: - TableView Datasource Methods
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItem?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell", for: indexPath)
        
        if let item = todoItem?[indexPath.row] {
          
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            
            cell.textLabel?.text = "No Items Added"
            
        }
        
        
        
//        before Refactor
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
//MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("itemOfRowCalled")
        
        if let item = todoItem?[indexPath.row] {
            do{
                try realm.write {
//                  realm,delete(item)
                    item.done = !item.done
            }
            } catch {
                print("Error saving done status \(error)")
            }
            
            tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//MARK: - Add new ITEM and Save
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
    
        let alert = UIAlertController(title: "Add new Todoay item ", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            // what will happend once the user click Add Item button on UI button
            
            if let currentCatagory = self.selectedCatagory {
                do{
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dataCreated = Date()
                    currentCatagory.items.append(newItem)
                }
                }catch{
                    print("Error saving new items,\(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
// MARK: - ModuleMenupulated Method.
    
    
    //TODO: - load
    
    func loadItems(){
        
        let itemArray = selectedCatagory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }

}

//MARK: - seacrh Bar method

extension TodoeyViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItem = todoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath:"dataCreated",ascending: true )


    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {

                searchBar.resignFirstResponder()
            }

        }
    }
}

