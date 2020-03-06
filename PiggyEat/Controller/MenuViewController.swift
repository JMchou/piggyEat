
//
//  MenuViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/15/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class MenuViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let menu = Menu.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FoodItemCell", bundle: nil), forCellReuseIdentifier: "FoodItemCell")
        tableView.separatorStyle = .none
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        menu.loadData(context: context)
    }
    
    // MARK: - Table view data sources
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.foodArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell", for: indexPath) as! FoodItemCell
        cell.delegate = self
        
        let item = menu.foodArray[indexPath.row]
        cell.nameLabel.text = item.name
        cell.imageLabel.image = UIImage(named: "piggy\(Int.random(in: 1...9))")
        //cell.textLabel?.textColor = UIColor.black

        return cell
    }

    //MARK: - Add New items

    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add new food item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            
            newItem.name = textField.text!
            newItem.date = Date()
            
            self.menu.foodArray.append(newItem)
            self.menu.saveData(context: self.context)
            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a food option"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Delete", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
} 

//MARK: - SwipeCellKit protocol

extension MenuViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.menu.deleteData(context: self.context, at: indexPath.row)
            self.tableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return [deleteAction]
    }
    
}
