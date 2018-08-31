//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Narongsak_O on 30/8/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import RealmSwift

class CatagoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var catagoryArray: Results<Catagory>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCatagory()

    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catagoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        
        cell.textLabel?.text = catagoryArray?[indexPath.row].name ?? "No Catagory Added Yet"
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    
    //TODO: - save
    
    func save(catagory:Catagory){
        
        do{
            try real.write(){
                realm.add(catagory)
            }
        print("save data")
        } catch {
            print("Error saving context\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //TODO: - load
    
    func loadCatagory() {
        
        catagories = realm.objects(Catagory.self)
        
        tableView.reloadData()
        
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoay Catagories", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Catagory", style: .default) { (action) in
            
            // what will happend once the user click Add Item button on UI button
            let newCatagory = Catagory()
            
            newCatagory.name = textField.text!
            
            self.save(catagory:newCatagory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new catagory"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoeyViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCatagory = catagoryArray?[indexPath.row] ??
        }
    }
    
    
    
}
