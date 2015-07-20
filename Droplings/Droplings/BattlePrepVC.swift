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
    
    @IBOutlet weak var playerDefenseLabel: UILabel!
    @IBOutlet weak var playerHealthLabel: UILabel!
    @IBOutlet weak var playerStaminaLabel: UILabel!
    @IBOutlet weak var playerDamageLabel: UILabel!
    @IBOutlet weak var playerRegenLabel: UILabel!
    
    @IBOutlet weak var opponentDefenseLabel: UILabel!
    @IBOutlet weak var opponentHealthLabel: UILabel!
    @IBOutlet weak var opponentStaminaLabel: UILabel!
    @IBOutlet weak var opponentDamageLabel: UILabel!
    @IBOutlet weak var opponentRegenLabel: UILabel!
    
    var opponentDropling: Dropling = Dropling()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opponentDropling = Dropling(name: "Opponent", type: "Green", damage: Int(arc4random_uniform(12) + 1), defense: Int(arc4random_uniform(10) + 1), health: Int(arc4random_uniform(20) + 40), stamina: Int(arc4random_uniform(20) + 40), regen: Int(arc4random_uniform(5) + 1), image: "Green Dropling 1", imageHat: "", imageShirt: "", equipment: Item())
        
        opponentDefenseLabel.text = "Def: \(opponentDropling.defense.description)"
        opponentHealthLabel.text = "HP: \(opponentDropling.health.description)"
        opponentStaminaLabel.text = "Sta: \(opponentDropling.stamina.description)"
        opponentDamageLabel.text = "Dmg: \(opponentDropling.damage.description)"
        opponentRegenLabel.text = "Rgn: \(opponentDropling.regen.description)"
        
        var subVC: BattlePrepSubVC = childViewControllers[0] as! BattlePrepSubVC
        subVC.parent = subVC.parentViewController as? BattlePrepVC
        
    }
    
}
