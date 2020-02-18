
//
//  MenuViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/15/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UITableViewController {
    
    private var foodSelection: Results<Item>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Table view data sources
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodSelection?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItem", for: indexPath)
        
        if let item = foodSelection?[indexPath.row] {
            cell.textLabel?.text = item.name
        } else {
            cell.textLabel?.text = "Empty menu. Add your favorite food!"
        }
        
        return cell
    }
    
    //MARK: - Add New items
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new food item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.name = textField.text!
            newItem.date = Date()
            
            self.saveData(data: newItem)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a food option"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Supporting functions
    
    func saveData(data: Item) {
        do {
        try realm.write {
            realm.add(data)
            }
        } catch {
            print("Error saving data. \(data)")
        }
    }
    
    func loadData() {
        foodSelection = realm.objects(Item.self)
    }
} 
