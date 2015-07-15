//
//  BattlePrepSubVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/13/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class BattlePrepSubVC: UIViewController {
    
    // TableView outlet.
    @IBOutlet weak var tableView: UITableView!
    
    // Outlets for selectable images.
    @IBOutlet weak var dropImage: UIImageView!
    @IBOutlet weak var hatImage: UIImageView!
    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    
    // Variable that stores parent view controller, which is defined in BattlePrepVC.
    var parent: BattlePrepVC?

    // Variable that contains the currently selected image.
    var selectedIcon: UIImageView?
    
    // MARK: - PLACEHOLDER VARIABLES
    // If this app is ever expanded, these variables will need to be replaced with something more dynamic.
    var droplings: [Dropling] = [Dropling(name: "Bilbo", type: "Blue", damage: 3, defense: 1, health: 30, stamina: 30, regen: 3, image: "Blue Dropling 1", imageHat: "", imageShirt: "", equipment: ""), Dropling(name: "Hershey", type: "Yellow", damage: 2, defense: 5, health: 25, stamina: 35, regen: 2, image: "Yellow Dropling 1", imageHat: "", imageShirt: "", equipment: ""), Dropling(name: "The Rock", type: "Orange", damage: 8, defense: 8, health: 40, stamina: 40, regen: 5, image: "Orange Dropling 1", imageHat: "", imageShirt: "", equipment: "")]
    
    var hats: [Hat] = [Hat(name: "Wizard Cap", desc: "", damage: 0, defense: 0, health: 0, stamina: 5, regen: 1, image: ""), Hat(name: "Fez", desc: "", damage: -1, defense: 2, health: 5, stamina: 0, regen: 0, image: "")]
    
    var shirts: [Shirt] = [Shirt(name: "Flora", desc: "", damage: 0, defense: -1, health: 10, stamina: 0, regen: 0, image: ""), Shirt(name: "Spiked", desc: "", damage: 3, defense: 1, health: 0, stamina: 0, regen: -1, image: ""), Shirt(name: "Steel", desc: "", damage: -2, defense: 6, health: 5, stamina: -5, regen: 0, image: "")]
    
    var items: [Item] = [Item(name: "Medallion of Strength", desc: "", damage: 5, defense: 0, health: 0, stamina: 0, regen: 0, image: ""), Item(name: "Balance Pin", desc: "", damage: 1, defense: 1, health: 5, stamina: 5, regen: 1, image: ""), Item(name: "Pet Rock", desc: "", damage: 0, defense: 0, health: 15, stamina: -5, regen: 0, image: ""), Item(name: "Ice Orb", desc: "", damage: 0, defense: 2, health: 0, stamina: 5, regen: 2, image: "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - @IBActions
    
    /// Starts the battle.
    @IBAction func battleAction(sender: UIButton) {
        
    }
    
    /// Lets the user choose their dropling via the tableview.
    @IBAction func droplingChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
    }
    
    /// Lets the user choose their dropling's hat via the tableview.
    @IBAction func hatChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
    }
    
    /// Lets the user choose their dropling's item via the tableview.
    @IBAction func itemChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
    }
    
    /// Lets the user choose their dropling's shirt via the tableview.
    @IBAction func shirtChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view as? UIImageView
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
    }
    
    
}
