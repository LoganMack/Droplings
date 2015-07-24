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
    
    // Outlets for selectable buttons and their images.
    @IBOutlet weak var dropButton: UIView!
    @IBOutlet weak var hatButton: UIView!
    @IBOutlet weak var shirtButton: UIView!
    @IBOutlet weak var itemButton: UIView!
    
    @IBOutlet weak var dropImage: UIImageView!
    @IBOutlet weak var hatImage: UIImageView!
    @IBOutlet weak var shirtImage: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var selectContainer: UIView!
    
    // Variable that stores parent view controller, which is defined in BattlePrepVC.
    var parent: BattlePrepVC?
    
    // Variable that contains the currently selected image.
    var selectedIcon: UIView?
    
    var selectedDropling: Dropling?
    var selectedHat: Hat?
    var selectedShirt: Shirt?
    var selectedItem: Item?
    
    var selectedCellDropling: NSIndexPath? = nil
    var selectedCellHat: NSIndexPath? = nil
    var selectedCellShirt: NSIndexPath? = nil
    var selectedCellItem: NSIndexPath? = nil
    
    
    
    // MARK: - PLACEHOLDER VARIABLES
    // If this app is ever expanded, these variables will need to be replaced with something more dynamic.
    let droplings: [Dropling] = [Dropling(name: "Blue", type: "Blue", damage: 8, defense: 1, health: 30, stamina: 30, regen: 3, image: "Blue Dropling 1", imageHat: "", imageShirt: "", equipment: Item()), Dropling(name: "Hershey", type: "Yellow", damage: 5, defense: 5, health: 25, stamina: 35, regen: 2, image: "Leafy Dropling 1", imageHat: "", imageShirt: "", equipment: Item()), Dropling(name: "The Rock", type: "Orange", damage: 8, defense: 8, health: 40, stamina: 40, regen: 5, image: "Molten Dropling 1", imageHat: "", imageShirt: "", equipment: Item())]
    
    let hats: [Hat] = [Hat(name: "Wizard Cap", desc: "", damage: 0, defense: 0, health: 0, stamina: 5, regen: 1, image: "Blue Dropling 2"), Hat(name: "Fez", desc: "", damage: -1, defense: 2, health: 5, stamina: 0, regen: 0, image: "Blue Dropling 2")]
    
    let shirts: [Shirt] = [Shirt(name: "Flora", desc: "", damage: 2, defense: -1, health: 10, stamina: 0, regen: 0, image: "Yellow Dropling 2"), Shirt(name: "Spiked", desc: "", damage: 3, defense: 1, health: 0, stamina: 0, regen: -1, image: "Yellow Dropling 2"), Shirt(name: "Steel", desc: "", damage: -2, defense: 6, health: 5, stamina: -5, regen: 0, image: "Yellow Dropling 2")]
    
    let items: [Item] = [Item(name: "Medallion of Strength", desc: "", damage: 5, defense: 0, health: 0, stamina: 0, regen: 0, image: "Orange Dropling 2"), Item(name: "Balance Pin", desc: "", damage: 1, defense: 1, health: 5, stamina: 5, regen: 1, image: "Orange Dropling 2"), Item(name: "Pet Rock", desc: "", damage: 0, defense: 0, health: 15, stamina: -5, regen: 0, image: "Orange Dropling 2"), Item(name: "Ice Orb", desc: "", damage: 0, defense: 2, health: 0, stamina: 5, regen: 2, image: "Orange Dropling 2")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewContainer.layer.cornerRadius = 20
        selectContainer.layer.cornerRadius = 20
        
        dropButton.layer.cornerRadius = dropButton.bounds.height * 0.4
        hatButton.layer.cornerRadius = hatButton.bounds.height * 0.4
        shirtButton.layer.cornerRadius = shirtButton.bounds.height * 0.4
        itemButton.layer.cornerRadius = itemButton.bounds.height * 0.4
        
        battleButton.layer.cornerRadius = battleButton.bounds.height * 0.4
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var battleVC = segue.destinationViewController as! BattleVC
        
        battleVC.selectedDropling = Dropling(name: selectedDropling!.name, type: selectedDropling!.type, damage: selectedDropling!.damage + selectedHat!.damage + selectedShirt!.damage, defense: selectedDropling!.defense + selectedHat!.defense + selectedShirt!.defense, health: selectedDropling!.health + selectedHat!.health + selectedShirt!.health, stamina: selectedDropling!.stamina + selectedHat!.stamina + selectedShirt!.stamina, regen: selectedDropling!.regen + selectedHat!.regen + selectedShirt!.regen, image: selectedDropling!.image, imageHat: selectedDropling!.imageHat, imageShirt: selectedDropling!.imageShirt, equipment: selectedItem!)
        
        battleVC.selectedHat = selectedHat
        battleVC.selectedShirt = selectedShirt
        battleVC.selectedItem = selectedItem
        battleVC.selectedOpponent = parent?.opponentDropling
    }
    
    
    // MARK: - CUSTOM FUNCTIONS
    /// Checks to see if the user has selected a dropling, hat, shirt, and item for the battle. If they have, we unhide the "Battle" button.
    func checkBattle () {
        if selectedDropling != nil && selectedHat != nil && selectedShirt != nil && selectedItem != nil {
            battleButton.hidden = false
        }
    }
    
    func selectOnlyDropling () {
        parent!.playerDefenseLabel.text = selectedDropling!.defense.description
        parent!.playerHealthLabel.text = selectedDropling!.health.description
        parent!.playerStaminaLabel.text = selectedDropling!.stamina.description
        parent!.playerDamageLabel.text = selectedDropling!.damage.description
        parent!.playerRegenLabel.text = selectedDropling!.regen.description
    }
    
    func selectDroplingAndHat () {
        parent!.playerDefenseLabel.text = "\(selectedDropling!.defense + selectedHat!.defense)"
        parent!.playerHealthLabel.text = "\(selectedDropling!.health + selectedHat!.health)"
        parent!.playerStaminaLabel.text = "\(selectedDropling!.stamina + selectedHat!.stamina)"
        parent!.playerDamageLabel.text = "\(selectedDropling!.damage + selectedHat!.damage)"
        parent!.playerRegenLabel.text = "\(selectedDropling!.regen + selectedHat!.regen)"
    }
    
    func selectDroplingAndShirt () {
        parent!.playerDefenseLabel.text = "\(selectedDropling!.defense + selectedShirt!.defense)"
        parent!.playerHealthLabel.text = "\(selectedDropling!.health + selectedShirt!.health)"
        parent!.playerStaminaLabel.text = "\(selectedDropling!.stamina + selectedShirt!.stamina)"
        parent!.playerDamageLabel.text = "\(selectedDropling!.damage + selectedShirt!.damage)"
        parent!.playerRegenLabel.text = "\(selectedDropling!.regen + selectedShirt!.regen)"
    }
    
    func selectAll () {
        parent!.playerDefenseLabel.text = "\(selectedDropling!.defense + selectedHat!.defense + selectedShirt!.defense)"
        parent!.playerHealthLabel.text = "\(selectedDropling!.health + selectedHat!.health + selectedShirt!.health)"
        parent!.playerStaminaLabel.text = "\(selectedDropling!.stamina + selectedHat!.stamina + selectedShirt!.stamina)"
        parent!.playerDamageLabel.text = "\(selectedDropling!.damage + selectedHat!.damage + selectedShirt!.damage)"
        parent!.playerRegenLabel.text = "\(selectedDropling!.regen + selectedHat!.regen + selectedShirt!.regen)"
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
            selectedIcon?.layer.borderWidth = 1
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 1
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
            selectedIcon?.layer.borderWidth = 1
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 1
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
            selectedIcon?.layer.borderWidth = 1
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 1
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
            selectedIcon?.layer.borderWidth = 1
        } else {
            selectedIcon = sender.view
            selectedIcon?.layer.borderColor = UIColor.blackColor().CGColor
            selectedIcon?.layer.borderWidth = 1
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
        
//        var accButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        accButton.setImage(UIImage(named: "Blue Dropling 1"), forState: UIControlState.Selected)
//        
//        accButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        // Configure the cell.
        
//        //cell.accessoryView = accButton
        
        if selectedIcon?.tag == 0 {
            if indexPath == selectedCellDropling {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.name.text = droplings[indexPath.row].name;
            cell.cellImage.image = UIImage(named: droplings[indexPath.row].image)
            cell.damage.text = droplings[indexPath.row].damage.description;
            cell.defense.text = droplings[indexPath.row].defense.description;
            cell.health.text = droplings[indexPath.row].health.description;
            cell.stamina.text = droplings[indexPath.row].stamina.description;
            cell.regen.text = droplings[indexPath.row].regen.description;
            
        } else if selectedIcon?.tag == 1 {
            if indexPath == selectedCellHat {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.name.text = hats[indexPath.row].name;
            cell.cellImage.image = UIImage(named: hats[indexPath.row].image)
            cell.damage.text = hats[indexPath.row].damage.description;
            cell.defense.text = hats[indexPath.row].defense.description;
            cell.health.text = hats[indexPath.row].health.description;
            cell.stamina.text = hats[indexPath.row].stamina.description;
            cell.regen.text = hats[indexPath.row].regen.description;
            
        } else if selectedIcon?.tag == 2 {
            if indexPath == selectedCellShirt {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.name.text = shirts[indexPath.row].name;
            cell.cellImage.image = UIImage(named: shirts[indexPath.row].image)
            cell.damage.text = shirts[indexPath.row].damage.description;
            cell.defense.text = shirts[indexPath.row].defense.description;
            cell.health.text = shirts[indexPath.row].health.description;
            cell.stamina.text = shirts[indexPath.row].stamina.description;
            cell.regen.text = shirts[indexPath.row].regen.description;
            
        } else if selectedIcon?.tag == 3 {
            if indexPath == selectedCellItem {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
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
        tableView.reloadData()
        if selectedIcon?.tag == 0 {
            selectedCellDropling = indexPath
            selectedDropling = droplings[indexPath.row]
            parent?.playerImage.image = UIImage(named: selectedDropling!.image)
            dropImage.image = UIImage(named: selectedDropling!.image)
            
            if selectedHat != nil && selectedShirt != nil {
                selectAll()
                
            } else if selectedHat != nil {
                selectDroplingAndHat()
                
            } else if selectedShirt != nil {
                selectDroplingAndShirt()
                
            } else {
                hatButton.hidden = false
                shirtButton.hidden = false
                itemButton.hidden = false
                selectOnlyDropling()
            }
            
            checkBattle()
            
        } else if selectedIcon?.tag == 1 {
            selectedCellHat = indexPath
            selectedHat = hats[indexPath.row]
            
            if selectedHat != nil && selectedShirt != nil {
                selectAll()
                
            } else if selectedHat != nil {
                selectDroplingAndHat()
                
            } else if selectedShirt != nil {
                selectDroplingAndShirt()
                
            } else {
                selectOnlyDropling()
            }
            
            checkBattle()
            
        } else if selectedIcon?.tag == 2 {
            selectedCellShirt = indexPath
            selectedShirt = shirts[indexPath.row]
            
            if selectedHat != nil && selectedShirt != nil {
                selectAll()
                
            } else if selectedHat != nil {
                selectDroplingAndHat()
                
            } else if selectedShirt != nil {
                selectDroplingAndShirt()
                
            } else {
                selectOnlyDropling()
            }
            
            checkBattle()
            
        } else if selectedIcon?.tag == 3 {
            selectedCellItem = indexPath
            selectedItem = items[indexPath.row]
            
            checkBattle()
            
        }
    }
}
