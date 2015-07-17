//
//  BattlePrepVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/13/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class BattlePrepVC: UIViewController {
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var opponentImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var subVC: BattlePrepSubVC = childViewControllers[0] as! BattlePrepSubVC
        subVC.parent = subVC.parentViewController as? BattlePrepVC
        
    }
    
}
