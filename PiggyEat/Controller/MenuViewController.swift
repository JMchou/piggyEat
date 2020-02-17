
//
//  MenuViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/15/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    private var foodSelection = ["Sushi", "Panda", "chipotle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodSelection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItem", for: indexPath)
        
        cell.textLabel?.text = foodSelection[indexPath.row]
        return cell
    }
    
    //MARK: - Add New items
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new food item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let text = textField.text {
                self.foodSelection.append(text)
                self.tableView.reloadData()
            }
        }
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a food option"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
