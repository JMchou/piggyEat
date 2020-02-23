//
//  FoodItemCell.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/19/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit
import SwipeCellKit

class FoodItemCell: SwipeTableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = bgView.layer.frame.size.height / 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    } 
    
}
