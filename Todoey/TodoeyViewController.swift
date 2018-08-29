//
//  ViewController.swift
//  Todoey
//
//  Created by Narongsak_O on 28/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import CoreData

class TodoeyViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    loadItems()
        
    }

//MARK: - TableView Datasource Methods
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoViewCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//MARK: - Add new ITEM
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
    
        let alert = UIAlertController(title: "Add new Todoay item ", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            // what will happend once the user click Add Item button on UI button
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
         
            self.saveItems()
         
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
// MARK: - ModuleMenupulated Method.
    
    func saveItems(){
        
        do{
        try context.save()
        } catch {
           print("Error saving context\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest() ){
       
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
         itemArray = try context.fetch(request)
        }catch{
         print("Error cannot fectching from context\(error)")
        }
    }

}

//MARK: - seacrh Bar method

extension TodoeyViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
//        request.predicate = predicate
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
//        request.sortDescriptors = [sortDescriptor]
        
        loadItems(with: request)
        
    }
}

