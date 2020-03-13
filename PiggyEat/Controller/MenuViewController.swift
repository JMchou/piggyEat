
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
import PopupDialog

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let menu = Menu.sharedInstance
    private var popupDialog: PopupDialog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "FoodItemCell", bundle: nil), forCellReuseIdentifier: "FoodItemCell")
        tableView.separatorStyle = .none
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
        let predicate = selectMealType()
        menu.loadData(context: context, predicate: predicate)
    }
    
    //MARK: - Add New items
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        showCustomAlertView(animated: true)
    }
    
    private func configureCustomAlertView() {
        
        let dialogAppearance = PopupDialogContainerView.appearance()
        let overlayAppearance = PopupDialogOverlayView.appearance()
        
        dialogAppearance.backgroundColor = .clear
        
        if self.traitCollection.userInterfaceStyle == .dark  {
            overlayAppearance.color = .systemPink
        } else {
            overlayAppearance.color = .systemPink
        }
    }
    
    private func showCustomAlertView(animated: Bool) {
        
        let customVC = AddMenuViewController(nibName: "AddMenuViewController", bundle: nil)
        customVC.delegate = self
        // Create the dialog
        let popup = PopupDialog(viewController: customVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        popupDialog = popup
        present(popup, animated: animated, completion: nil)
    }
    
    //MARK: - Display food of selected meal type
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        
        let predicate = selectMealType()
        menu.loadData(context: context, predicate: predicate)
        tableView.reloadData()
    }
    
    func selectMealType() -> NSPredicate? {
        
        var predicate: NSPredicate?
        switch segmentControl.selectedSegmentIndex {
        case 1:
            predicate = NSPredicate(format: "isBreakfast == YES")
        case 2:
            predicate = NSPredicate(format: "isLunch == YES")
        case 3:
            predicate = NSPredicate(format: "isDinner == YES")
        default:
            return nil
        }
        
        return predicate
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
        deleteAction.backgroundColor = .clear
        
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.backgroundColor = .clear
        return options
        
    }
    
}

//MARK: - Custom Add Menu delegate methods

extension MenuViewController: AddMenuViewControllerDelegate {
    func addMenuViewController(mainButtonIsPressed: Bool, foodName: String, selectedMealType: Dictionary<String, Bool>) {
        if mainButtonIsPressed {
            let newItem = Item(context: self.context)
            
            newItem.name = foodName
            newItem.date = Date()
            newItem.imageNumber = Int16(Int.random(in: 1...9))
            
            for mealType in selectedMealType {
                switch mealType.key {
                case "isBreakfast":
                    newItem.isBreakfast = mealType.value
                case "isLunch":
                    newItem.isLunch = mealType.value
                case "isDinner":
                    newItem.isDinner = mealType.value
                default:
                    return
                }
            }
            
            let prediate = selectMealType()
            self.menu.saveData(context: self.context)
            self.menu.loadData(context: context, predicate: prediate)
            self.popupDialog?.dismiss()
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView data source

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell", for: indexPath) as! FoodItemCell
        cell.delegate = self
        
        let item = menu.foodArray[indexPath.row]
        cell.nameLabel.text = item.name
        
        let image = UIImage(named: "piggy\(Int(item.imageNumber))")
        cell.imageLabel.image = image
        //cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
}
