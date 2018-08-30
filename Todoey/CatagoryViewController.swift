//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Narongsak_O on 30/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {
    
    var catagoryArray = [Catagory]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCatagory()

    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catagoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        
        cell.textLabel?.text = catagoryArray[indexPath.row].name
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCatagory(){
        
        do{
        try context.save()
        print("save data")
        } catch {
            print("Error saving context\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCatagory() {
        let request : NSFetchRequest<Catagory> = Catagory.fetchRequest()
        
        do{
           catagoryArray = try context.fetch(request)
        } catch {
            print("Error cannot fetching from context\(error)")
        }
        
        tableView.reloadData()
        print("reload")
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoay Catagories", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Catagory", style: .default) { (action) in
            
            // what will happend once the user click Add Item button on UI button
            let newCatagory = Catagory(context: self.context)
            
            newCatagory.name = textField.text!
            
            self.catagoryArray.append(newCatagory)
            
            self.saveCatagory()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new catagory"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView Delegate Methods
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        saveCatagory()
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
    
    
    
}
