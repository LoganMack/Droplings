//
//  BattleStatsVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class BattleStatsVC: UIViewController {
    
    var victory = true
    var damageDealt = 0
    var damageRecieved = 0
    var staminaUsed = 0
    var skillsUsed = 0

    @IBOutlet weak var victoryLabel: UILabel!
    @IBOutlet weak var damageDealtLabel: UILabel!
    @IBOutlet weak var damageRecievedLabel: UILabel!
    @IBOutlet weak var staminaUsedLabel: UILabel!
    @IBOutlet weak var skillsUsedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        damageDealtLabel.text = "Damage Dealt: \(damageDealt)"
        damageRecievedLabel.text = "Damage Recieved: \(damageRecieved)"
        staminaUsedLabel.text = "Stamina Used: \(staminaUsed)"
        skillsUsedLabel.text = "Skills Used: \(skillsUsed)"

        if victory {
            victoryLabel.text = "Victory!"
        } else {
            victoryLabel.text = "Defeat!"
        }
    }

}
