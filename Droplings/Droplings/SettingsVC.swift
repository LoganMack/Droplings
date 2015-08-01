//
//  SettingsVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/22/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

// Unused for now.
class SettingsVC: UIViewController {

    @IBOutlet weak var backButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = backButton.bounds.height * 0.4
    }

    @IBAction func backButtonTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
