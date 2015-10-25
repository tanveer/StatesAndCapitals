//
//  SecondViewController.swift
//  StatesAndCapitals
//
//  Created by Tanveer Bashir on 10/24/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    var points = Int()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = "Congratulations \(name) you have earned \(points) points out of 50"
    }
}
