//
//  HelpVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    @IBOutlet weak var helpTitle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helpTitle.layer.cornerRadius = 10
        helpTitle.clipsToBounds = true
    }

}
