//
//  BattleVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/15/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class BattleVC: UIViewController {
    
    // Placeholder Skill variables. If this app is ever expanded upon, these will be replaced with something more dynamic.
    var skills: [Skill] = [Skill(name: "Poison Spit", desc: "", damage: -1, defense: -1, health: -1, stamina: 0, regen: 0, time: 3, affectsOpponent: true, stCost: 18, hpCost: 0, image: ""), Skill(name: "Rock Wall", desc: "", damage: 0, defense: 5, health: 0, stamina: 0, regen: 0, time: 2, affectsOpponent: false, stCost: 12, hpCost: 0, image: ""), Skill(name: "Swiftness", desc: "", damage: 0, defense: 1, health: 0, stamina: 5, regen: 0, time: 1, affectsOpponent: false, stCost: 0, hpCost: 5, image: ""), Skill(name: "Rage", desc: "", damage: 4, defense: 1, health: 0, stamina: 0, regen: 0, time: 2, affectsOpponent: false, stCost: 10, hpCost: 5, image: "")]
    
    // Variables being passed in from BattlePrepSubVC.
    var selectedDropling: Dropling?
    var selectedHat: Hat?
    var selectedShirt: Shirt?
    var selectedItem: Item?
    var selectedOpponent: Dropling?
    
    // Main view used for fade in.
    @IBOutlet weak var fadeView: UIView!
    
    // Sets up timer to be used for the fade.
    var fadeTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disables user interaction until the fade is complete.
        view.userInteractionEnabled = false
        fadeView.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Starts the fade when the view appears. Every time this timer finishes, it calls the function "fade".
        fadeTimer = NSTimer.scheduledTimerWithTimeInterval(0.025, target: self, selector: "fade", userInfo: nil, repeats: true)
    }
    
    /// This function fades the view from black to white.
    func fade () {
        if fadeView.alpha < 1 {
            fadeView.alpha = fadeView.alpha + 0.005
        } else {
            fadeTimer.invalidate()
            fadeView.backgroundColor = UIColor.whiteColor()
            fadeView.alpha = 1
            view.userInteractionEnabled = true
        }
    }
    
}
