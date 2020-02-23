//
//  ViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/12/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let menu = Menu.sharedInstance
    
    @IBOutlet weak var foodChoice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        guard let selectedFood = menu.foodArray.randomElement()?.name else{
            foodChoice.text = "Empty menu!"
            return 
        }
        foodChoice.text = selectedFood
    }

    private func randomNumber(min: Int, max: Int) -> Int {
        return Int.random(in: min...max)
    }

    
    //MARK: - Data Handle
    
    func loadData() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            menu.foodArray =  try context.fetch(request)
        } catch {
            print("Error occurred when trying to fetch data. \(error)")
        }
    }
}
