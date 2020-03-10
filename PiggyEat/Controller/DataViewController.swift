//
//  DataViewController.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 3/8/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var displayImage: UIImage?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = displayImage
    }

}
