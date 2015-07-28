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
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var newBattleButton: UIView!
    @IBOutlet weak var mainMenuButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.layer.cornerRadius = container.bounds.height * 0.4
        newBattleButton.layer.cornerRadius = newBattleButton.bounds.height * 0.4
        mainMenuButton.layer.cornerRadius = mainMenuButton.bounds.height * 0.4
        
        damageDealtLabel.text = "Damage Dealt: \(damageDealt)"
        damageRecievedLabel.text = "Damage Taken: \(damageRecieved)"
        staminaUsedLabel.text = "Stamina Used: \(staminaUsed)"
        skillsUsedLabel.text = "Skills Used: \(skillsUsed)"

        if victory {
            victoryLabel.text = "Victory!"
        } else {
            victoryLabel.text = "Defeat!"
        }
    }

}
