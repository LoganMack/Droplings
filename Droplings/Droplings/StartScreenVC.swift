//
//  StartScreenVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class StartScreenVC: UIViewController {
    
    @IBOutlet weak var battle: UIView!
    @IBOutlet weak var farm: UIView!
    @IBOutlet weak var farmhouse: UIView!
    @IBOutlet weak var help: UIView!
    @IBOutlet weak var settings: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        battle.layer.cornerRadius = battle.bounds.height * 0.4
        farm.layer.cornerRadius = farm.bounds.height * 0.4
        farmhouse.layer.cornerRadius = farmhouse.bounds.height * 0.4
        help.layer.cornerRadius = help.bounds.height * 0.4
        settings.layer.cornerRadius = settings.bounds.height * 0.4
        
    }

}
