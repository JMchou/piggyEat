//
//  AddMenuViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 3/12/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit

class AddMenuViewController: UIViewController {
    
    
    @IBOutlet weak var breakfastButton: UIButton!
    @IBOutlet weak var lunchButton: UIButton!
    @IBOutlet weak var dinnerButton: UIButton!
    
    var delegate: AddMenuViewControllerDelegate?
    var mealType = ["isBreakfast": false,
                    "isLunch": false,
                    "isDinner": false]
    
    @IBOutlet weak var enterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkBoxPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            
            let buttonTitle = sender.titleLabel?.text
            switch buttonTitle {
            case "Breakfast":
                self.mealType["isBreakfast"] = sender.isSelected
            case "Lunch":
                self.mealType["isLunch"] = sender.isSelected
            case "Dinner":
                self.mealType["isDinner"] = sender.isSelected
            default:
                return
            }
            
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    @IBAction func mainButtonPressed(_ sender: UIButton) {
        
        for value in mealType.values {
            if !value {
                return
            }
        }
        
        guard let textFieldText = enterTextField.text else {
            return
        }
        
        guard textFieldText != "" else {
            return
        }
        delegate?.addMenuViewController(mainButtonIsPressed: true, foodName: textFieldText, selectedMealType: mealType)
    }
    
}

//MARK: - TextField Delegate methods

extension AddMenuViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //limits the user from entering more than 25 characters. 
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false}
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 25
    }
}

//MARK: - delegate methods

protocol AddMenuViewControllerDelegate {
    
    func addMenuViewController(mainButtonIsPressed: Bool, foodName: String, selectedMealType: Dictionary<String, Bool>)
    
}


