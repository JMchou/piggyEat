//
//  AlertViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 3/10/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    var delegate: AlertViewControllerDelegate?
    var displayedText: String = "Your favorite food!"

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var foodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodLabel.text = displayedText

    }
    
    @IBAction func dismissedButtonPressed(_ sender: UIButton) {
        delegate?.alertViewController(dismissIsPressed: true)
    }
    

}

//MARK: - Protocol

protocol AlertViewControllerDelegate {
    
    func alertViewController(dismissIsPressed: Bool)
}
