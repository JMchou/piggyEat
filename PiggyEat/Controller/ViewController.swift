//
//  ViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/12/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let foodSelection = ["Sushi", "Panda", "chipotle"]

    
    @IBOutlet weak var foodChoice: UILabel!
    @IBOutlet weak var bottomPigImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let number = randomNumber(min: 1, max: 9)
        bottomPigImage.image = UIImage(named: "piggy\(number).png")
        
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let position = randomNumber(min: 0, max: foodSelection.count - 1)
        let pigNumber = randomNumber(min: 1, max: 9)
        
        foodChoice.text = foodSelection[position]
        bottomPigImage.image = UIImage(named: "piggy\(pigNumber).png")
    }
    
    private func randomNumber(min: Int, max: Int) -> Int {
        return Int.random(in: min...max)
    }
    
}

