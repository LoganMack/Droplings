//
//  BattlePrepVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/13/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class BattlePrepVC: UIViewController {
    
    // IBOutlets
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
    
    @IBOutlet weak var playerShirt: UIImageView!
    @IBOutlet weak var opponentShirt: UIImageView!
    @IBOutlet weak var playerHat: UIImageView!
    @IBOutlet weak var opponentHat: UIImageView!
    
    // Giving our opponent an inital value.
    var opponentDropling: Dropling = Dropling()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Giving our opponent some random attributes.
        opponentDropling = Dropling(name: "Opponent", type: "Green", damage: Int(arc4random_uniform(15) + 10), defense: Int(arc4random_uniform(8) + 1), health: Int(arc4random_uniform(30) + 40), stamina: Int(arc4random_uniform(30) + 40), regen: Int(arc4random_uniform(15) + 5), image: "Orange Dropling 1", imageHat: "", imageShirt: "", equipment: Item())
        
        // Making more sexy rounded corners.
        userStatContainer.layer.cornerRadius = userStatContainer.bounds.height * 0.4
        opponentStatContainer.layer.cornerRadius = opponentStatContainer.bounds.height * 0.4
        
        opponentDefenseLabel.text = opponentDropling.defense.description
        opponentHealthLabel.text = opponentDropling.health.description
        opponentStaminaLabel.text = opponentDropling.stamina.description
        opponentDamageLabel.text = opponentDropling.damage.description
        opponentRegenLabel.text = opponentDropling.regen.description
        
        // Setting up the container view controller below as a child of this view, and telling it that this view controller is its parent.
        var subVC: BattlePrepSubVC = childViewControllers[0] as! BattlePrepSubVC
        subVC.parent = subVC.parentViewController as? BattlePrepVC
        
    }
    
    // Unwind function for BattleStatsVC.
    @IBAction func unwindToBattlePrepSub(segue: UIStoryboardSegue) {
    }
    
}
