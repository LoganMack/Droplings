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
    
    @IBOutlet weak var userStatContainer: UIView!
    @IBOutlet weak var opponentStatContainer: UIView!
    
    var opponentDropling: Dropling = Dropling()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opponentDropling = Dropling(name: "Opponent", type: "Green", damage: Int(arc4random_uniform(12) + 1), defense: Int(arc4random_uniform(10) + 1), health: Int(arc4random_uniform(20) + 40), stamina: Int(arc4random_uniform(20) + 40), regen: Int(arc4random_uniform(5) + 1), image: "Green Dropling 1", imageHat: "", imageShirt: "", equipment: Item())
        
        userStatContainer.layer.cornerRadius = userStatContainer.bounds.height * 0.4
        opponentStatContainer.layer.cornerRadius = opponentStatContainer.bounds.height * 0.4
        
        opponentDefenseLabel.text = opponentDropling.defense.description
        opponentHealthLabel.text = opponentDropling.health.description
        opponentStaminaLabel.text = opponentDropling.stamina.description
        opponentDamageLabel.text = opponentDropling.damage.description
        opponentRegenLabel.text = opponentDropling.regen.description
        
        var subVC: BattlePrepSubVC = childViewControllers[0] as! BattlePrepSubVC
        subVC.parent = subVC.parentViewController as? BattlePrepVC
        
    }
    
    @IBAction func unwindToBattlePrepSub(segue: UIStoryboardSegue) {
    }
    
}
