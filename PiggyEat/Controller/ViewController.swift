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
    @IBOutlet weak var bottomPigImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let number = randomNumber(min: 1, max: 9)
        bottomPigImage.image = UIImage(named: "piggy\(number).png")
        
        loadData()
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        var maxNumber = 0
        
        if menu.foodArray.count > 0 {
            maxNumber = menu.foodArray.count
            let position = randomNumber(min: 0, max: maxNumber - 1)
            foodChoice.text = menu.foodArray[position].name
        }
        
        let pigNumber = randomNumber(min: 1, max: 9)
        bottomPigImage.image = UIImage(named: "piggy\(pigNumber).png")

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

extension ViewController:   UINavigationControllerDelegate {
    
    
}
