//
//  BattlePrepSubVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/13/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

// Cell Reuse Identifier
let cellReuse = "cellReuse"

class BattlePrepSubVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // TableView outlet.
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var battleButton: UIView!
    
    // Outlets for selectable images.
    @IBOutlet weak var dropImage: UIImageView!
    @IBOutlet weak var hatImage: UIImageView!
    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    
    // Variable that stores parent view controller, which is defined in BattlePrepVC.
    var parent: BattlePrepVC?
    
    // Variable that contains the currently selected image.
    var selectedIcon: UIView?
    
    var selectedDropling: Dropling?
    var selectedHat: Hat?
    var selectedShirt: Shirt?
    var selectedItem: Item?
    
    
    
    // MARK: - PLACEHOLDER VARIABLES
    // If this app is ever expanded, these variables will need to be replaced with something more dynamic.
    var droplings: [Dropling] = [Dropling(name: "Bilbo", type: "Blue", damage: 3, defense: 1, health: 30, stamina: 30, regen: 3, image: "Blue Dropling 1", imageHat: "", imageShirt: "", equipment: ""), Dropling(name: "Hershey", type: "Yellow", damage: 2, defense: 5, health: 25, stamina: 35, regen: 2, image: "Yellow Dropling 1", imageHat: "", imageShirt: "", equipment: ""), Dropling(name: "The Rock", type: "Orange", damage: 8, defense: 8, health: 40, stamina: 40, regen: 5, image: "Orange Dropling 1", imageHat: "", imageShirt: "", equipment: "")]
    
    var hats: [Hat] = [Hat(name: "Wizard Cap", desc: "", damage: 0, defense: 0, health: 0, stamina: 5, regen: 1, image: ""), Hat(name: "Fez", desc: "", damage: -1, defense: 2, health: 5, stamina: 0, regen: 0, image: "")]
    
    var shirts: [Shirt] = [Shirt(name: "Flora", desc: "", damage: 0, defense: -1, health: 10, stamina: 0, regen: 0, image: ""), Shirt(name: "Spiked", desc: "", damage: 3, defense: 1, health: 0, stamina: 0, regen: -1, image: ""), Shirt(name: "Steel", desc: "", damage: -2, defense: 6, health: 5, stamina: -5, regen: 0, image: "")]
    
    var items: [Item] = [Item(name: "Medallion of Strength", desc: "", damage: 5, defense: 0, health: 0, stamina: 0, regen: 0, image: ""), Item(name: "Balance Pin", desc: "", damage: 1, defense: 1, health: 5, stamina: 5, regen: 1, image: ""), Item(name: "Pet Rock", desc: "", damage: 0, defense: 0, health: 15, stamina: -5, regen: 0, image: ""), Item(name: "Ice Orb", desc: "", damage: 0, defense: 2, health: 0, stamina: 5, regen: 2, image: "")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var battleVC = segue.destinationViewController as! BattleVC
        
        battleVC.selectedDropling = selectedDropling
        battleVC.selectedHat = selectedHat
        battleVC.selectedShirt = selectedShirt
        battleVC.selectedItem = selectedItem
    }
    
    
    // MARK: - CUSTOM FUNCTIONS
    /// Checks to see if the user has selected a dropling, hat, shirt, and item for the battle. If they have, we unhide the "Battle" button.
    func checkBattle () {
        if selectedDropling != nil && selectedHat != nil && selectedShirt != nil && selectedItem != nil {
            battleButton.hidden = false
        }
    }
    
    
    
    // MARK: - @IBActions
    /// Starts the battle.
    @IBAction func battleAction(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("battle", sender: self)
    }
    
    /// Lets the user choose their dropling via the tableview.
    @IBAction func droplingChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
        tableView.hidden = false
        tableView.reloadData()
    }
    
    /// Lets the user choose their dropling's hat via the tableview.
    @IBAction func hatChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
        tableView.hidden = false
        tableView.reloadData()
    }
    
    /// Lets the user choose their dropling's item via the tableview.
    @IBAction func itemChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
        tableView.hidden = false
        tableView.reloadData()
    }
    
    /// Lets the user choose their dropling's shirt via the tableview.
    @IBAction func shirtChange(sender: UITapGestureRecognizer) {
        if selectedIcon != nil {
            selectedIcon?.layer.borderWidth = 0
            
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 3
        }
        
        tableView.hidden = false
        tableView.reloadData()
    }
    
    
    
    // MARK: - TABLE VIEW DELEGATES
    // Determines number of rows in the tableview by counting the amount of entries in the selected array of data.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIcon?.tag == 0 {
            return droplings.count
        } else if selectedIcon?.tag == 1 {
            return hats.count
        } else if selectedIcon?.tag == 2 {
            return shirts.count
        } else if selectedIcon?.tag == 3 {
            return items.count
        }
        
        return 1
    }
    
    // Sets up the cells in the tableview.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Recycle cells
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuse, forIndexPath: indexPath) as! BattlePrepTableViewCell;
        
        // Configure the cell.
        if selectedIcon?.tag == 0 {
            cell.name.text = droplings[indexPath.row].name;
            cell.cellImage.image = UIImage(named: droplings[indexPath.row].image)
            cell.damage.text = droplings[indexPath.row].damage.description;
            cell.defense.text = droplings[indexPath.row].defense.description;
            cell.health.text = droplings[indexPath.row].health.description;
            cell.stamina.text = droplings[indexPath.row].stamina.description;
            cell.regen.text = droplings[indexPath.row].regen.description;
            
        } else if selectedIcon?.tag == 1 {
            cell.name.text = hats[indexPath.row].name;
            cell.cellImage.image = UIImage(named: hats[indexPath.row].image)
            cell.damage.text = hats[indexPath.row].damage.description;
            cell.defense.text = hats[indexPath.row].defense.description;
            cell.health.text = hats[indexPath.row].health.description;
            cell.stamina.text = hats[indexPath.row].stamina.description;
            cell.regen.text = hats[indexPath.row].regen.description;
            
        } else if selectedIcon?.tag == 2 {
            cell.name.text = shirts[indexPath.row].name;
            cell.cellImage.image = UIImage(named: shirts[indexPath.row].image)
            cell.damage.text = shirts[indexPath.row].damage.description;
            cell.defense.text = shirts[indexPath.row].defense.description;
            cell.health.text = shirts[indexPath.row].health.description;
            cell.stamina.text = shirts[indexPath.row].stamina.description;
            cell.regen.text = shirts[indexPath.row].regen.description;
            
        } else if selectedIcon?.tag == 3 {
            cell.name.text = items[indexPath.row].name;
            cell.cellImage.image = UIImage(named: items[indexPath.row].image)
            cell.damage.text = items[indexPath.row].damage.description;
            cell.defense.text = items[indexPath.row].defense.description;
            cell.health.text = items[indexPath.row].health.description;
            cell.stamina.text = items[indexPath.row].stamina.description;
            cell.regen.text = items[indexPath.row].regen.description;
            
        }
        
        // Return the configured cell.
        return cell;
    }
    
    // Determines what to do when a cell in the tableview is tapped.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selectedIcon?.tag == 0 {
            parent?.playerImage.image = UIImage(named: droplings[indexPath.row].image)
            dropImage.image = UIImage(named: droplings[indexPath.row].image)
            selectedDropling = droplings[indexPath.row]
            
            checkBattle()
            
        } else if selectedIcon?.tag == 1 {
            selectedHat = hats[indexPath.row]
            println("HAT CHANGED")
            
            checkBattle()
            
        } else if selectedIcon?.tag == 2 {
            selectedShirt = shirts[indexPath.row]
            println("SHIRT CHANGED")
            
            checkBattle()
            
        } else if selectedIcon?.tag == 3 {
            selectedItem = items[indexPath.row]
            println("ITEM CHANGED")
            
            checkBattle()
            
        }
    }
}
