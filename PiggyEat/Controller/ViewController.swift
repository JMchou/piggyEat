//
//  ViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/12/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    private let realm = try! Realm()
    private var foodSelection: Results<Item>?
    
    @IBOutlet weak var foodChoice: UILabel!
    @IBOutlet weak var bottomPigImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let number = randomNumber(min: 1, max: 9)
        bottomPigImage.image = UIImage(named: "piggy\(number).png")
        
        loadData()
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        guard let menu = foodSelection, menu.count > 0 else {
            return
        }
        
        let position = randomNumber(min: 0, max: menu.count - 1)
        let pigNumber = randomNumber(min: 1, max: 9)
        
        foodChoice.text = menu[position].name
        bottomPigImage.image = UIImage(named: "piggy\(pigNumber).png")
        
    }
    
    private func randomNumber(min: Int, max: Int) -> Int {
        return Int.random(in: min...max)
    }
    
    
    //MARK: - Data
    
    func loadData() {
        foodSelection = realm.objects(Item.self)
    }
}

