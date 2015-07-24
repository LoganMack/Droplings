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
    let skills: [Skill] = [Skill(name: "Poison Spit", desc: "", damage: -1, defense: -1, health: -1, stamina: 0, regen: 0, time: 3, affectsOpponent: true, stCost: 18, hpCost: 0, image: "Blue Dropling 2"),
        Skill(name: "Rock Wall", desc: "", damage: 0, defense: 5, health: 0, stamina: 0, regen: 0, time: 2, affectsOpponent: false, stCost: 12, hpCost: 0, image: "Blue Dropling 2"),
        Skill(name: "Drain", desc: "", damage: 0, defense: -1, health: 0, stamina: -5, regen: 0, time: 1, affectsOpponent: true, stCost: 0, hpCost: 5, image: "Blue Dropling 2"),
        Skill(name: "Rage", desc: "", damage: 4, defense: 1, health: 0, stamina: 0, regen: 0, time: 2, affectsOpponent: false, stCost: 10, hpCost: 5, image: "Blue Dropling 2")]
    
    // Variables being passed in from BattlePrepSubVC.
    var selectedDropling: Dropling?
    var selectedHat: Hat?
    var selectedShirt: Shirt?
    var selectedItem: Item?
    var selectedOpponent: Dropling?
    
    var playerSkills: [Skill] = []
    var opponentSkills: [Skill] = []
    
    // Main view used for fade in.
    @IBOutlet weak var fadeView: UIView!
    
    // Sets up timer to be used for the fade.
    var fadeTimer = NSTimer()
    
    
    
    
    
    
    // MARK: - BATTLE VARIABLES
    // Marking this because it's important to make it clear what is used during the battle itself. The battle code might get a bit convoluted, so this has to be organized.
    
    var victory = false
    var damageDealt = 0
    var damageRecieved = 0
    var staminaUsed = 0
    var skillsUsed = 0
    
    // Variable that contains the currently selected skill/item.
    var selectedAttack: UIView?
    var selectedAttackIndex = 0
    
    // These variables track the buff enabled on each player, and how many turns it has left.
    var playerBuffTime = 0
    var opponentBuffTime = 0
    
    // These variables track the nerf enabled on each player, and how many turns it has left.
    var playerNerfTime = 0
    var opponentNerfTime = 0
    
    // These variables store the previous dmg, def, and rgn values before they were buffed or nerfed, so after the effect expires, they return to these values.
    var playerOriginalDamage = 100
    var playerOriginalDefense = 100
    var playerOriginalRegen = 100
    
    var opponentOriginalDamage = 100
    var opponentOriginalDefense = 100
    var opponentOriginalRegen = 100
    
    // These variables store the current buff and nerf effects.
    var playerBuffHealth = 0
    var playerBuffStamina = 0
    var playerBuffDamage = 0
    var playerBuffDefense = 0
    var playerBuffRegen = 0
    
    var playerNerfHealth = 0
    var playerNerfStamina = 0
    var playerNerfDamage = 0
    var playerNerfDefense = 0
    var playerNerfRegen = 0
    
    var opponentBuffHealth = 0
    var opponentBuffStamina = 0
    var opponentBuffDamage = 0
    var opponentBuffDefense = 0
    var opponentBuffRegen = 0
    
    var opponentNerfHealth = 0
    var opponentNerfStamina = 0
    var opponentNerfDamage = 0
    var opponentNerfDefense = 0
    var opponentNerfRegen = 0
    
    // Timers
    var playerAttackAnimationTimer = NSTimer()
    var opponentTurnTimer = NSTimer()
    var opponentAttackAnimationTimer = NSTimer()
    
    // Max Health and Stamina
    var playerMaxHealth = 0
    var playerMaxStamina = 0
    var opponentMaxHealth = 0
    var opponentMaxStamina = 0
    
    // Basic Stats
    var playerCurrentHealth = 100
    var playerCurrentStamina = 100
    var playerCurrentDamage = 100
    var playerCurrentDefense = 100
    var playerCurrentRegen = 100
    
    var opponentCurrentHealth = 100
    var opponentCurrentStamina = 100
    var opponentCurrentDamage = 100
    var opponentCurrentDefense = 100
    var opponentCurrentRegen = 100
    
    var aiSkillSelector = 0
    
    var preventEndlessLoop = 50
    
    // Battle UI Outlets
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var opponentName: UILabel!
    
    @IBOutlet weak var playerDamage: UILabel!
    @IBOutlet weak var playerDefense: UILabel!
    @IBOutlet weak var playerRegen: UILabel!
    @IBOutlet weak var playerHealth: UILabel!
    @IBOutlet weak var playerStamina: UILabel!
    
    @IBOutlet weak var opponentDamage: UILabel!
    @IBOutlet weak var opponentDefense: UILabel!
    @IBOutlet weak var opponentRegen: UILabel!
    @IBOutlet weak var opponentHealth: UILabel!
    @IBOutlet weak var opponentStamina: UILabel!
    
    @IBOutlet weak var playerDroplingImage: UIImageView!
    @IBOutlet weak var opponentDroplingImage: UIImageView!
    
    @IBOutlet weak var playerSkill1: UIImageView!
    @IBOutlet weak var playerSkill2: UIImageView!
    @IBOutlet weak var playerSkill3: UIImageView!
    @IBOutlet weak var playerSkill4: UIImageView!
    
    @IBOutlet weak var opponentSkill1: UIImageView!
    @IBOutlet weak var opponentSkill2: UIImageView!
    @IBOutlet weak var opponentSkill3: UIImageView!
    @IBOutlet weak var opponentSkill4: UIImageView!
    
    // Skill Outlets
    @IBOutlet var skillNames: [UILabel]!
    @IBOutlet var skillImages: [UIImageView]!
    @IBOutlet var skillDamages: [UILabel]!
    @IBOutlet var skillDefenses: [UILabel]!
    @IBOutlet var skillHealths: [UILabel]!
    @IBOutlet var skillStaminas: [UILabel]!
    @IBOutlet var skillRegens: [UILabel]!
    
    // Item Outlets
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDamage: UILabel!
    @IBOutlet weak var itemDefense: UILabel!
    @IBOutlet weak var itemHealth: UILabel!
    @IBOutlet weak var itemStamina: UILabel!
    @IBOutlet weak var itemRegen: UILabel!
    
    @IBOutlet weak var actionContainer: UIView!
    @IBOutlet weak var itemContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerDroplingImage.image = UIImage(named: selectedDropling!.image)
        
        playerOriginalDamage = selectedDropling!.damage
        playerOriginalDefense = selectedDropling!.defense
        playerOriginalRegen = selectedDropling!.regen
        
        opponentOriginalDamage = selectedOpponent!.damage
        opponentOriginalDefense = selectedOpponent!.defense
        opponentOriginalRegen = selectedOpponent!.regen
        
        playerMaxHealth = selectedDropling!.health
        playerMaxStamina = selectedDropling!.stamina
        opponentMaxHealth = selectedOpponent!.health
        opponentMaxStamina = selectedOpponent!.stamina
        
        playerCurrentHealth = playerMaxHealth
        playerCurrentStamina = playerMaxStamina
        playerCurrentDamage = playerOriginalDamage
        playerCurrentDefense = playerOriginalDefense
        playerCurrentRegen = playerOriginalRegen
        
        opponentCurrentHealth = opponentMaxHealth
        opponentCurrentStamina = opponentMaxStamina
        opponentCurrentDamage = opponentOriginalDamage
        opponentCurrentDefense = opponentOriginalDefense
        opponentCurrentRegen = opponentOriginalRegen
        
        playerSkills = skills
        opponentSkills = skills
        
        for var i = 0; i < playerSkills.count; ++i {
            skillNames[i].text = "  \(playerSkills[i].name) - HP: \(playerSkills[i].hpCost) - ST: \(playerSkills[i].stCost) - T: \(playerSkills[i].time)"
            skillImages[i].image = UIImage(named: playerSkills[i].image)
            skillDamages[i].text = "Damage: \(playerSkills[i].damage)"
            skillDefenses[i].text = "Defense: \(playerSkills[i].defense)"
            skillHealths[i].text = "Health: \(playerSkills[i].health)"
            skillStaminas[i].text = "Stamina: \(playerSkills[i].stamina)"
            skillRegens[i].text = "Regen: \(playerSkills[i].regen)"
            
            if playerSkills[i].affectsOpponent == true {
                skillNames[i].backgroundColor = UIColor.redColor()
            } else {
                skillNames[i].backgroundColor = UIColor.blueColor()
            }
        }
        
        itemImage.image = UIImage(named: selectedItem!.image)
        itemDamage.text = "Damage: \(selectedItem!.damage.description)"
        itemDefense.text = "Defense: \(selectedItem!.defense.description)"
        itemHealth.text = "Health: \(selectedItem!.health.description)"
        itemStamina.text = "Stamina: \(selectedItem!.stamina.description)"
        itemRegen.text = "Regen: \(selectedItem!.regen.description)"
        
        playerName.text = selectedDropling!.name
        opponentName.text = selectedOpponent!.name
        
        updateUI()
        
        // Disables user interaction until the fade is complete.
        view.userInteractionEnabled = false
        fadeView.alpha = 0
        
        fadeTimer = NSTimer.scheduledTimerWithTimeInterval(0.025, target: self, selector: "fade", userInfo: nil, repeats: true)
    }
    
//    override func viewDidAppear(animated: Bool) {
//        
//        // Starts the fade when the view appears. Every time this timer finishes, it calls the function "fade".
//        fadeTimer = NSTimer.scheduledTimerWithTimeInterval(0.025, target: self, selector: "fade", userInfo: nil, repeats: true)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var statsVC = segue.destinationViewController as! BattleStatsVC
        
        statsVC.victory = victory
        statsVC.damageDealt = damageDealt
        statsVC.damageRecieved = damageRecieved
        statsVC.staminaUsed = staminaUsed
        statsVC.skillsUsed = skillsUsed
    }
    
    // MARK: - CUSTOM FUNCTIONS
    /// This function fades the view from black to white.
    func fade () {
        if fadeView.alpha < 1 {
            fadeView.alpha = fadeView.alpha + 0.005
        } else {
            fadeTimer.invalidate()
            fadeView.backgroundColor = UIColor.whiteColor()
            fadeView.alpha = 1
            view.userInteractionEnabled = true
            
            var chooseFirst = Int(arc4random_uniform(2))
            println(chooseFirst)
            if chooseFirst == 0 {
                battlePlayerTurn()
            } else {
                battleOpponentTurn()
            }
        }
    }
    
    func updateUI () {
        
        playerDamage.text = "Dmg: \(playerCurrentDamage)"
        playerDefense.text = "Def: \(playerCurrentDefense)"
        playerRegen.text = "Rgn: \(playerCurrentRegen)"
        playerHealth.text = "HP: \(playerCurrentHealth)/\(playerMaxHealth)"
        playerStamina.text = "ST: \(playerCurrentStamina)/\(playerMaxStamina)"
        
        opponentDamage.text = "Dmg: \(opponentCurrentDamage)"
        opponentDefense.text = "Def: \(opponentCurrentDefense)"
        opponentRegen.text = "Rgn: \(opponentCurrentRegen)"
        opponentHealth.text = "HP: \(opponentCurrentHealth)/\(opponentMaxHealth)"
        opponentStamina.text = "ST: \(opponentCurrentStamina)/\(opponentMaxStamina)"
        
    }
    
    // Runs when it is the player's turn.
    func battlePlayerTurn () {
        
        view.userInteractionEnabled = false
        actionContainer.hidden = false
        updateUI()
        
        if opponentCurrentHealth <= 0 {
            playerVictory()
            return
        }
        
        if playerBuffTime > 0 || playerNerfTime > 0 {
            playerCurrentHealth = playerCurrentHealth + playerBuffHealth + playerNerfHealth
            playerCurrentStamina = playerCurrentStamina + playerBuffStamina + playerNerfStamina
            playerCurrentDamage = playerOriginalDamage + playerBuffDamage + playerNerfDamage
            playerCurrentDefense = playerOriginalDefense + playerBuffDefense + playerNerfDefense
            playerCurrentRegen = playerOriginalRegen + playerBuffRegen + playerNerfRegen
            
            --playerBuffTime
            --playerNerfTime
        }
        
        playerCurrentStamina = playerCurrentStamina + playerCurrentRegen
        
        if playerCurrentStamina > playerMaxStamina {
            playerCurrentStamina = playerMaxStamina
        }
        
        if playerCurrentHealth > playerMaxHealth {
            playerCurrentHealth = playerMaxHealth
        }
        
        updateUI()
        
        if playerCurrentHealth <= 0 {
            opponentVictory()
            return
        }
        
        view.userInteractionEnabled = true
        
    }
    
    // Runs when it is the opponent's turn.
    func battleOpponentTurn () {
        
        view.userInteractionEnabled = false
        updateUI()
        
        if playerCurrentHealth <= 0 {
            opponentVictory()
            return
        }
        
        updateUI()
        
        if opponentCurrentHealth <= 0 {
            playerVictory()
            return
        }
        
        opponentSkillSelector()
        
        view.userInteractionEnabled = true
        
    }
    
    func opponentSkillSelector() {
        
        aiSkillSelector = Int(arc4random_uniform(4))
        
        if preventEndlessLoop >= 0 {
            if opponentCurrentStamina > opponentSkills[aiSkillSelector].stCost && opponentCurrentHealth > opponentSkills[aiSkillSelector].hpCost {
                opponentAttack()
            } else {
                --preventEndlessLoop
                opponentSkillSelector()
            }
        } else {
            preventEndlessLoop = 50
            opponentAttack()
        }
    }
    
    func opponentAttack() {
        
        if aiSkillSelector < 4 {
            if opponentSkills[aiSkillSelector].affectsOpponent {
                playerNerfHealth = opponentSkills[aiSkillSelector].health
                playerNerfStamina = opponentSkills[aiSkillSelector].stamina
                playerNerfDamage = opponentSkills[aiSkillSelector].damage
                playerNerfDefense = opponentSkills[aiSkillSelector].defense
                playerNerfRegen = opponentSkills[aiSkillSelector].regen
                
                opponentCurrentHealth = opponentCurrentHealth - opponentSkills[aiSkillSelector].hpCost
                opponentCurrentStamina = opponentCurrentStamina - opponentSkills[aiSkillSelector].stCost
                opponentNerfTime = opponentSkills[aiSkillSelector].time
                
            } else {
                opponentBuffHealth = opponentSkills[aiSkillSelector].health
                opponentBuffStamina = opponentSkills[aiSkillSelector].stamina
                opponentBuffDamage = opponentSkills[aiSkillSelector].damage
                opponentBuffDefense = opponentSkills[aiSkillSelector].defense
                opponentBuffRegen = opponentSkills[aiSkillSelector].regen
                
                opponentCurrentHealth = opponentCurrentHealth - opponentSkills[aiSkillSelector].hpCost
                opponentCurrentStamina = opponentCurrentStamina - opponentSkills[aiSkillSelector].stCost
                opponentBuffTime = opponentSkills[aiSkillSelector].time
                
            }
            
        } else {
            opponentBuffHealth = selectedItem!.health
            opponentBuffStamina = selectedItem!.stamina
            opponentBuffDamage = selectedItem!.damage
            opponentBuffDefense = selectedItem!.defense
            opponentBuffRegen = selectedItem!.regen
            
            opponentBuffTime = 1
        }
        
        opponentCurrentDamage = opponentOriginalDamage + opponentBuffDamage + opponentNerfDamage
        opponentCurrentDefense = opponentOriginalDefense + opponentBuffDefense + opponentNerfDefense
        opponentCurrentRegen = opponentOriginalRegen + opponentBuffRegen + opponentNerfRegen
        
        var opponentAttackValue = Int(arc4random_uniform(10)) + opponentCurrentDamage
        var playerDefenseValue = Int(arc4random_uniform(10)) + playerCurrentDefense
        
        var netDamage = opponentAttackValue - playerDefenseValue
        
        println("OPPONENT ATTACK")
        println(opponentAttackValue)
        println(playerDefenseValue)
        
        if netDamage <= 0 {
            battlePlayerTurn()
        } else {
            playerCurrentHealth = playerCurrentHealth - netDamage
            damageRecieved = damageRecieved + netDamage
            battlePlayerTurn()
        }
        
    }
    
    // Runs if the player wins.
    func playerVictory () {
        victory = true
        performSegueWithIdentifier("end", sender: self)
    }
    
    // Runs if the opponent wins.
    func opponentVictory () {
        victory = false
        performSegueWithIdentifier("end", sender: self)
    }
    
    
    // MARK: - @IBActions
    // Tap Gesture Recognizers
    @IBAction func skill1Tap(sender: UITapGestureRecognizer) {
        if selectedAttack == sender.view {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = nil
            
        } else if selectedAttack != nil {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = sender.view
            
            if playerSkills[0].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 0
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[0].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 0
            
        }
    }
    
    @IBAction func skill2Tap(sender: UITapGestureRecognizer) {
        if selectedAttack == sender.view {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = nil
            
        } else if selectedAttack != nil {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = sender.view
            
            if playerSkills[1].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 1
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[1].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 1
            
        }
    }
    
    @IBAction func skill3Tap(sender: UITapGestureRecognizer) {
        if selectedAttack == sender.view {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = nil
            
        } else if selectedAttack != nil {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = sender.view
            
            if playerSkills[2].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 2
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[2].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 2
            
        }
    }
    
    @IBAction func skill4Tap(sender: UITapGestureRecognizer) {
        if selectedAttack == sender.view {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = nil
            
        } else if selectedAttack != nil {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = sender.view
            
            if playerSkills[3].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 3
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[3].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.redColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 3
            
        }
    }
    
    @IBAction func item1Tap(sender: UITapGestureRecognizer) {
        if selectedAttack == sender.view {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = nil
            
        } else if selectedAttack != nil {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = sender.view
            
            selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 4
            
        } else {
            selectedAttack = sender.view
            
            selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            selectedAttack?.layer.borderWidth = 3
            selectedAttackIndex = 4
            
        }
    }
    
    @IBAction func attackTap(sender: UITapGestureRecognizer) {
        if selectedAttack != nil {
            
            if selectedAttackIndex < 4 {
                if playerSkills[selectedAttackIndex].stCost > playerCurrentStamina {
                    return
                } else if playerSkills[selectedAttackIndex].affectsOpponent {
                    opponentNerfHealth = playerSkills[selectedAttackIndex].health
                    opponentNerfStamina = playerSkills[selectedAttackIndex].stamina
                    opponentNerfDamage = playerSkills[selectedAttackIndex].damage
                    opponentNerfDefense = playerSkills[selectedAttackIndex].defense
                    opponentNerfRegen = playerSkills[selectedAttackIndex].regen
                    
                    playerCurrentHealth = playerCurrentHealth - playerSkills[selectedAttackIndex].hpCost
                    playerCurrentStamina = playerCurrentStamina - playerSkills[selectedAttackIndex].stCost
                    staminaUsed = staminaUsed + playerSkills[selectedAttackIndex].stCost
                    opponentNerfTime = playerSkills[selectedAttackIndex].time
                    
                } else {
                    playerBuffHealth = playerSkills[selectedAttackIndex].health
                    playerBuffStamina = playerSkills[selectedAttackIndex].stamina
                    playerBuffDamage = playerSkills[selectedAttackIndex].damage
                    playerBuffDefense = playerSkills[selectedAttackIndex].defense
                    playerBuffRegen = playerSkills[selectedAttackIndex].regen
                    
                    playerCurrentHealth = playerCurrentHealth - playerSkills[selectedAttackIndex].hpCost
                    playerCurrentStamina = playerCurrentStamina - playerSkills[selectedAttackIndex].stCost
                    playerBuffTime = playerSkills[selectedAttackIndex].time
                    
                }
                
                ++skillsUsed
                
            } else {
                playerBuffHealth = selectedItem!.health
                playerBuffStamina = selectedItem!.stamina
                playerBuffDamage = selectedItem!.damage
                playerBuffDefense = selectedItem!.defense
                playerBuffRegen = selectedItem!.regen
                
                playerBuffTime = 3
                
                itemContainer.hidden = true
            }
        }
        
        playerCurrentDamage = playerOriginalDamage + playerBuffDamage + playerNerfDamage
        playerCurrentDefense = playerOriginalDefense + playerBuffDefense + playerNerfDefense
        playerCurrentRegen = playerOriginalRegen + playerBuffRegen + playerNerfRegen
        
        var playerAttackValue = Int(arc4random_uniform(10)) + playerCurrentDamage
        var opponentDefenseValue = Int(arc4random_uniform(10)) + opponentCurrentDefense
        
        var netDamage = playerAttackValue - opponentDefenseValue
        
        println("PLAYER ATTACK")
        println(playerAttackValue)
        println(opponentDefenseValue)
        
        if netDamage <= 0 {
            if opponentBuffTime > 0 || opponentNerfTime > 0 {
                opponentCurrentHealth = opponentCurrentHealth + opponentBuffHealth + opponentNerfHealth
                opponentCurrentStamina = opponentCurrentStamina + opponentBuffStamina + opponentNerfStamina
                opponentCurrentDamage = opponentOriginalDamage + opponentBuffDamage + opponentNerfDamage
                opponentCurrentDefense = opponentOriginalDefense + opponentBuffDefense + opponentNerfDefense
                opponentCurrentRegen = opponentOriginalRegen + opponentBuffRegen + opponentNerfRegen
                
                --opponentBuffTime
                --opponentNerfTime
            }
            
            opponentCurrentStamina = opponentCurrentStamina + opponentCurrentRegen
            
            if opponentCurrentStamina > opponentMaxStamina {
                opponentCurrentStamina = playerMaxStamina
            }
            
            if opponentCurrentHealth > opponentMaxHealth {
                opponentCurrentHealth = opponentMaxHealth
            }
            
            updateUI()
            actionContainer.hidden = true
            opponentTurnTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "battleOpponentTurn", userInfo: nil, repeats: false)
        } else {
            opponentCurrentHealth = opponentCurrentHealth - netDamage
            damageDealt = damageDealt + netDamage
            
            if opponentBuffTime > 0 || opponentNerfTime > 0 {
                opponentCurrentHealth = opponentCurrentHealth + opponentBuffHealth + opponentNerfHealth
                opponentCurrentStamina = opponentCurrentStamina + opponentBuffStamina + opponentNerfStamina
                opponentCurrentDamage = opponentOriginalDamage + opponentBuffDamage + opponentNerfDamage
                opponentCurrentDefense = opponentOriginalDefense + opponentBuffDefense + opponentNerfDefense
                opponentCurrentRegen = opponentOriginalRegen + opponentBuffRegen + opponentNerfRegen
                
                --opponentBuffTime
                --opponentNerfTime
            }
            
            opponentCurrentStamina = opponentCurrentStamina + opponentCurrentRegen
            
            if opponentCurrentStamina > opponentMaxStamina {
                opponentCurrentStamina = playerMaxStamina
            }
            
            if opponentCurrentHealth > opponentMaxHealth {
                opponentCurrentHealth = opponentMaxHealth
            }
            
            updateUI()
            actionContainer.hidden = true
            opponentTurnTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "battleOpponentTurn", userInfo: nil, repeats: false)
        }
    }
}


























