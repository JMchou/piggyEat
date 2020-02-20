
//
//  MenuViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/15/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let menu = Menu.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FoodItemCell", bundle: nil), forCellReuseIdentifier: "FoodItemCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        loadData()
    }
    
    // MARK: - Table view data sources

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.foodArray.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell", for: indexPath) as! FoodItemCell

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

    //MARK: - Data Handle

    func saveData(data: Item) {
        do {
            try context.save()
        } catch {
            print("Error occurred when trying to save \(error)")
        }
    }

    func loadData() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            menu.foodArray =  try context.fetch(request)
        } catch {
            print("Error occurred when trying to fetch data. \(error)")
        }
    }
} 
