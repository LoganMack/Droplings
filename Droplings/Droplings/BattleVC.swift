//
//  BattleVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/15/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit
import AVFoundation

class BattleVC: UIViewController, AVAudioPlayerDelegate {
    
    // Placeholder Skill variables. If this app is ever expanded upon, these will be replaced with something more dynamic.
    let skills: [Skill] = [Skill(name: "Poison Spit", desc: "", damage: -1, defense: -1, health: -1, stamina: 0, regen: 0, time: 3, affectsOpponent: true, stCost: 18, hpCost: 0, image: "Item"),
        Skill(name: "Rock Wall", desc: "", damage: 0, defense: 5, health: 0, stamina: 0, regen: 0, time: 2, affectsOpponent: false, stCost: 12, hpCost: 0, image: "Item"),
        Skill(name: "Drain", desc: "", damage: 0, defense: -1, health: 0, stamina: -5, regen: 0, time: 1, affectsOpponent: true, stCost: 0, hpCost: 5, image: "Item"),
        Skill(name: "Rage", desc: "", damage: 4, defense: 1, health: 0, stamina: 0, regen: 0, time: 2, affectsOpponent: false, stCost: 10, hpCost: 5, image: "Item")]
    
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
    
    // Variables used to pass stats about the battle to the BattleStatsVC.
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
    
    // These variables store the current buff and nerf effects for both players.
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
    
    // Timers for managing the battle and its animations.
    var playerAttackAnimationTimer = NSTimer()
    var opponentTurnTimer = NSTimer()
    var opponentAttackAnimationTimer = NSTimer()
    var statShow1 = NSTimer()
    var statShowNext2 = NSTimer()
    var statShowNext3 = NSTimer()
    var bounceAnimationTimer = NSTimer()
    var revertAttackTextTimer = NSTimer()
    
    // Max Health and Stamina, used for health and stamina labels, and a couple of if checks.
    var playerMaxHealth = 0
    var playerMaxStamina = 0
    var opponentMaxHealth = 0
    var opponentMaxStamina = 0
    
    // Basic Stats pulled from droplings passed to us from battle prep.
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
    
    // Variable used to select a skill for the AI to use.
    var aiSkillSelector = 0
    
    // Used to prevent an endless loop when choosing a skill for the AI.
    var preventEndlessLoop = 3
    
    // Used during animations to determine which image to animate.
    var playerTurn = false
    
    var bounceAnimationNormal = true
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var attackSoundPlayer = AVAudioPlayer()
    
    
    
    // MARK: - @IBOutlets
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
    @IBOutlet weak var playerHat: UIImageView!
    @IBOutlet weak var playerShirt: UIImageView!
    
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
    
    // Outlets for various containers, used to give them rounded edges, and to hide them at certain points.
    @IBOutlet weak var actionContainer: UIView!
    @IBOutlet weak var itemContainer: UIView!
    @IBOutlet weak var playerStatsContainer: UIView!
    @IBOutlet weak var opponentStatsContainer: UIView!
    @IBOutlet weak var skill1Container: UIView!
    @IBOutlet weak var skill2Container: UIView!
    @IBOutlet weak var skill3Container: UIView!
    @IBOutlet weak var skill4Container: UIView!
    @IBOutlet weak var attackContainer: UIView!
    @IBOutlet weak var battleActionContainer: UIView!
    
    // Used when showing the user how much damage the attacker is doing, and how much of it the defender is blocking.
    @IBOutlet weak var userActionImage: UIImageView!
    @IBOutlet weak var opponentActionImage: UIImageView!
    @IBOutlet weak var userActionLabel: UILabel!
    @IBOutlet weak var opponentActionLabel: UILabel!
    @IBOutlet weak var middleActionLabel: UILabel!
    
    @IBOutlet weak var attackButtonText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileURL: NSURL = NSBundle.mainBundle().URLForResource("BattleMusic", withExtension: "mp3")!
        
        appDelegate.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
        
        appDelegate.avPlayer.delegate = self
        appDelegate.avPlayer.prepareToPlay()
        appDelegate.avPlayer.volume = 1.0
        
        appDelegate.avPlayer.play()
        
        
        let fileURLAttack: NSURL = NSBundle.mainBundle().URLForResource("Punch3", withExtension: "mp3")!
        
        attackSoundPlayer = AVAudioPlayer(contentsOfURL: fileURLAttack, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
        
        attackSoundPlayer.delegate = nil
        attackSoundPlayer.prepareToPlay()
        attackSoundPlayer.volume = 1.0
        
        
        bounceAnimationTimer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "bounceAnimation", userInfo: nil, repeats: true)
        
        // These make sure the lower half of the view is blank until we decide who goes first.
        actionContainer.hidden = true
        userActionImage.image = nil
        opponentActionImage.image = nil
        userActionLabel.text = "??"
        opponentActionLabel.text = "??"
        userActionLabel.hidden = true
        opponentActionLabel.hidden = true
        middleActionLabel.text = ""
        battleActionContainer.hidden = false
        battleActionContainer.hidden = false
        
        // Here we give everything some rounded corners.
        skill1Container.layer.cornerRadius = skill1Container.frame.height * 0.2
        skill2Container.layer.cornerRadius = skill2Container.frame.height * 0.2
        skill3Container.layer.cornerRadius = skill3Container.frame.height * 0.2
        skill4Container.layer.cornerRadius = skill4Container.frame.height * 0.2
        itemContainer.layer.cornerRadius = itemContainer.frame.height * 0.2
        attackContainer.layer.cornerRadius = attackContainer.frame.height * 0.2
        playerStatsContainer.layer.cornerRadius = playerStatsContainer.frame.height * 0.4
        opponentStatsContainer.layer.cornerRadius = opponentStatsContainer.frame.height * 0.4
        
        // Now we set the player's image to their selected dropling's image, and give it a hat and shirt too.
        playerDroplingImage.image = UIImage(named: selectedDropling!.image)
        playerHat.image = UIImage(named: selectedHat!.image)
        playerShirt.image = UIImage(named: selectedShirt!.image)
        
        // Now we make sure we store the original values for dmg, def, and rgn for both players. For later use.
        playerOriginalDamage = selectedDropling!.damage
        playerOriginalDefense = selectedDropling!.defense
        playerOriginalRegen = selectedDropling!.regen
        opponentOriginalDamage = selectedOpponent!.damage
        opponentOriginalDefense = selectedOpponent!.defense
        opponentOriginalRegen = selectedOpponent!.regen
        
        // We do the same with health and stamina, for use as a max health and max stamina limit.
        playerMaxHealth = selectedDropling!.health
        playerMaxStamina = selectedDropling!.stamina
        opponentMaxHealth = selectedOpponent!.health
        opponentMaxStamina = selectedOpponent!.stamina
        
        // Now we grab all of our starter values and give them to our current variables as well. Except for stamina, because the players always start with no stamina.
        playerCurrentHealth = playerMaxHealth
        playerCurrentStamina = 0
        playerCurrentDamage = playerOriginalDamage
        playerCurrentDefense = playerOriginalDefense
        playerCurrentRegen = playerOriginalRegen
        opponentCurrentHealth = opponentMaxHealth
        opponentCurrentStamina = 0
        opponentCurrentDamage = opponentOriginalDamage
        opponentCurrentDefense = opponentOriginalDefense
        opponentCurrentRegen = opponentOriginalRegen
        
        // -PLACEHOLDER- Gives the players skills to use.
        playerSkills = skills
        opponentSkills = skills
        
        // These set the background colors of the skill selectors to red if they affect the opponent.
        if playerSkills[0].affectsOpponent {
            skill1Container.backgroundColor = UIColor(red: 255 / 255, green: 252 / 255, blue: 198 / 255, alpha: 1)
        }
        
        if playerSkills[1].affectsOpponent {
            skill2Container.backgroundColor = UIColor(red: 255 / 255, green: 252 / 255, blue: 198 / 255, alpha: 1)
        }
        
        if playerSkills[2].affectsOpponent {
            skill3Container.backgroundColor = UIColor(red: 255 / 255, green: 252 / 255, blue: 198 / 255, alpha: 1)
        }
        
        if playerSkills[3].affectsOpponent {
            skill4Container.backgroundColor = UIColor(red: 255 / 255, green: 252 / 255, blue: 198 / 255, alpha: 1)
        }
        
        // Here we grab the player's skills and give their info to the skill selectors.
        for var i = 0; i < playerSkills.count; ++i {
            skillNames[i].text = "\(playerSkills[i].name) - HP: \(playerSkills[i].hpCost) - ST: \(playerSkills[i].stCost) - T: \(playerSkills[i].time)"
            skillImages[i].image = UIImage(named: playerSkills[i].image)
            skillDamages[i].text = "\(playerSkills[i].damage)"
            skillDefenses[i].text = "\(playerSkills[i].defense)"
            skillHealths[i].text = "\(playerSkills[i].health)"
            skillStaminas[i].text = "\(playerSkills[i].stamina)"
            skillRegens[i].text = "\(playerSkills[i].regen)"
        }
        
        // Same with the skills, we grab the item's info and give it to the item selector.
        //itemImage.image = UIImage(named: selectedItem!.image)
        itemDamage.text = "\(selectedItem!.damage.description)"
        itemDefense.text = "\(selectedItem!.defense.description)"
        itemHealth.text = "\(selectedItem!.health.description)"
        itemStamina.text = "\(selectedItem!.stamina.description)"
        itemRegen.text = "\(selectedItem!.regen.description)"
        
        // Now we set the names of the player and the opponent to their dropling's names.
        playerName.text = selectedDropling!.name
        opponentName.text = selectedOpponent!.name
        
        updateUI()
        
        // Disables user interaction until the fade-in animation is complete.
        view.userInteractionEnabled = false
        fadeView.alpha = 0
        
        // Starts a timer which starts the fade-in animation and repeats until the fade-in animation is complete.
        fadeTimer = NSTimer.scheduledTimerWithTimeInterval(0.025, target: self, selector: "fade", userInfo: nil, repeats: true)
    }
    
    // Segway used to transfer data over to BattleStatsVC. This is triggered when the battle ends, and BattleStatsVC displays the stats from the battle.
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
    
    // This function updates the basic stats UI for both players.
    func updateUI () {
        if playerCurrentHealth < 0 {
            playerCurrentHealth = 0
        }
        
        if playerCurrentStamina < 0 {
            playerCurrentStamina = 0
        }
        
        if opponentCurrentHealth < 0 {
            opponentCurrentHealth = 0
        }
        
        if opponentCurrentStamina < 0 {
            opponentCurrentStamina = 0
        }
        
        playerDamage.text = "\(playerCurrentDamage)"
        playerDefense.text = "\(playerCurrentDefense)"
        playerRegen.text = "\(playerCurrentRegen)"
        playerHealth.text = "\(playerCurrentHealth)/\(playerMaxHealth)"
        playerStamina.text = "\(playerCurrentStamina)/\(playerMaxStamina)"
        
        opponentDamage.text = "\(opponentCurrentDamage)"
        opponentDefense.text = "\(opponentCurrentDefense)"
        opponentRegen.text = "\(opponentCurrentRegen)"
        opponentHealth.text = "\(opponentCurrentHealth)/\(opponentMaxHealth)"
        opponentStamina.text = "\(opponentCurrentStamina)/\(opponentMaxStamina)"
        
    }
    
    func bounceAnimation () {
        if bounceAnimationNormal {
            playerDroplingImage.image = UIImage(named: "\(selectedDropling!.image)-2")
            playerHat.image = UIImage(named: "\(selectedHat!.image)-2")
            playerShirt.image = UIImage(named: "\(selectedShirt!.image)-2")
            opponentDroplingImage.image = UIImage(named: "\(selectedOpponent!.image)-2")
            
            bounceAnimationNormal = false
        } else {
            playerDroplingImage.image = UIImage(named: "\(selectedDropling!.image)")
            opponentDroplingImage.image = UIImage(named: "\(selectedOpponent!.image)")
            playerHat.image = UIImage(named: "\(selectedHat!.image)")
            playerShirt.image = UIImage(named: "\(selectedShirt!.image)")
            
            bounceAnimationNormal = true
        }
    }
    
    func revertAttackText () {
        attackButtonText.text = "ATTACK"
        attackContainer.userInteractionEnabled = true
    }
    
    // This function runs when it is the player's turn.
    func battlePlayerTurn () {
        
        view.userInteractionEnabled = false
        actionContainer.hidden = false
        battleActionContainer.hidden = true
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
            preventEndlessLoop = 3
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
        
        var opponentAttackValue = Int(arc4random_uniform(15)) + opponentCurrentDamage
        var playerDefenseValue = Int(arc4random_uniform(15)) + playerCurrentDefense
        
        var netDamage = opponentAttackValue - playerDefenseValue
        
        updateUI()
        
        println("OPPONENT ATTACK")
        println(opponentAttackValue)
        println(playerDefenseValue)
        
        playerTurn = false
        userActionImage.image = nil
        opponentActionImage.image = nil
        userActionLabel.text = "??"
        opponentActionLabel.text = "??"
        userActionLabel.hidden = true
        opponentActionLabel.hidden = true
        middleActionLabel.text = ""
        
        if netDamage <= 0 {
            battleActionContainer.hidden = false
            
            var array = [playerDefenseValue, opponentAttackValue]
            
            statShow1 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow:", userInfo: array, repeats: false)
            
            //battlePlayerTurn()
            
        } else {
            playerCurrentHealth = playerCurrentHealth - netDamage
            damageRecieved = damageRecieved + netDamage
            
            battleActionContainer.hidden = false
            
            var array = [playerDefenseValue, opponentAttackValue]
            
            statShow1 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow:", userInfo: array, repeats: false)
            
            //battlePlayerTurn()
        }
        
    }
    
    func statShow (timer: NSTimer) {
        
        var array: [Int] = []
        
        if playerTurn {
            userActionImage.image = UIImage(named: "attack")
            opponentActionImage.image = UIImage(named: "defense")
            userActionLabel.hidden = false
            opponentActionLabel.hidden = false
            
            array = timer.userInfo as! [Int]
            
            userActionLabel.text = array[0].description
            opponentActionLabel.text = array[1].description
            
            middleActionLabel.text = ">"
            
        } else {
            userActionImage.image = UIImage(named: "defense")
            opponentActionImage.image = UIImage(named: "attack")
            userActionLabel.hidden = false
            opponentActionLabel.hidden = false
            
            array = timer.userInfo as! [Int]
            
            userActionLabel.text = array[0].description
            opponentActionLabel.text = array[1].description
            
            middleActionLabel.text = "<"
        }
        
        var imageLocation = self.playerDroplingImage.frame
        var imageOpponentLocation = self.opponentDroplingImage.frame
        
        if playerTurn {
            
            UIView.animateWithDuration(1, delay: 2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.playerDroplingImage.frame = self.opponentDroplingImage.frame
                self.playerHat.frame = self.opponentDroplingImage.frame
                self.playerShirt.frame = self.opponentDroplingImage.frame
                
                }, completion: {finished in UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.playerDroplingImage.frame = imageLocation
                    self.playerHat.frame = imageLocation
                    self.playerShirt.frame = imageLocation}, completion: nil)})
            
        } else {
            
            UIView.animateWithDuration(1, delay: 2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.opponentDroplingImage.frame = self.playerDroplingImage.frame
                
                }, completion: {finished in UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {self.opponentDroplingImage.frame = imageOpponentLocation}, completion: nil)})
        }
        
        statShowNext2 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow2:", userInfo: array, repeats: false)
    }
    
    func statShow2 (timer: NSTimer) {
        
        attackSoundPlayer.play()
        
        var array: [Int] = []
        
        array = timer.userInfo as! [Int]
        
        userActionLabel.text = "\(array[0] - array[1])"
        opponentActionLabel.text = "\(array[1] - array[0])"
        
        if array[0] - array[1] < 0 {
            userActionLabel.text = "0"
        }
        
        if array[1] - array[0] < 0 {
            opponentActionLabel.text = "0"
        }
        
        updateUI()
        
        statShowNext3 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow3", userInfo: nil, repeats: false)
    }
    
    func statShow3 () {
        
        updateUI()
        
        if playerTurn {
            battleOpponentTurn()
        } else {
            battlePlayerTurn()
        }
        
        
    }
    
    // Runs if the player wins.
    func playerVictory () {
        victory = true
        appDelegate.avPlayer.stop()
        performSegueWithIdentifier("end", sender: self)
    }
    
    // Runs if the opponent wins.
    func opponentVictory () {
        victory = false
        appDelegate.avPlayer.stop()
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
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
            selectedAttackIndex = 0
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[0].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
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
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
            selectedAttackIndex = 1
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[1].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
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
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
            selectedAttackIndex = 2
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[2].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
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
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
            selectedAttackIndex = 3
            
        } else {
            selectedAttack = sender.view
            
            if playerSkills[3].affectsOpponent == true {
                selectedAttack?.layer.borderColor = UIColor.yellowColor().CGColor
            } else {
                selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            }
            
            selectedAttack?.layer.borderWidth = 2
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
            
            selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            selectedAttack?.layer.borderWidth = 2
            selectedAttackIndex = 4
            
        } else {
            selectedAttack = sender.view
            
            selectedAttack?.layer.borderColor = UIColor.blueColor().CGColor
            selectedAttack?.layer.borderWidth = 2
            selectedAttackIndex = 4
            
        }
    }
    
    @IBAction func attackTap(sender: UITapGestureRecognizer) {
        if selectedAttack != nil {
            
            if selectedAttackIndex < 4 {
                if playerSkills[selectedAttackIndex].stCost > playerCurrentStamina {
                    attackButtonText.text = "Stamina too low!"
                    attackContainer.userInteractionEnabled = false
                    revertAttackTextTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "revertAttackText", userInfo: nil, repeats: false)
                    return
                } else if playerSkills[selectedAttackIndex].hpCost > playerCurrentHealth {
                    attackButtonText.text = "Health too low!"
                    attackContainer.userInteractionEnabled = false
                    revertAttackTextTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "revertAttackText", userInfo: nil, repeats: false)
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
                playerCurrentHealth = playerCurrentHealth + selectedItem!.health
                playerCurrentStamina = playerCurrentStamina + selectedItem!.stamina
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
        
        var playerAttackValue = Int(arc4random_uniform(15)) + playerCurrentDamage
        var opponentDefenseValue = Int(arc4random_uniform(15)) + opponentCurrentDefense
        
        var netDamage = playerAttackValue - opponentDefenseValue
        
        updateUI()
        
        println("PLAYER ATTACK")
        println(playerAttackValue)
        println(opponentDefenseValue)
        
        userActionImage.image = nil
        opponentActionImage.image = nil
        userActionLabel.text = "??"
        opponentActionLabel.text = "??"
        userActionLabel.hidden = true
        opponentActionLabel.hidden = true
        middleActionLabel.text = ""
        
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
            
            actionContainer.hidden = true
            
            userActionImage.image = nil
            opponentActionImage.image = nil
            userActionLabel.text = "??"
            opponentActionLabel.text = "??"
            userActionLabel.hidden = true
            opponentActionLabel.hidden = true
            middleActionLabel.text = ""
            battleActionContainer.hidden = false
            
            var array = [playerAttackValue, opponentDefenseValue]
            
            playerTurn = true
            
            updateUI()
            
            statShow1 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow:", userInfo: array, repeats: false)
            
        } else {
            
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
            
            actionContainer.hidden = true
            
            userActionImage.image = nil
            opponentActionImage.image = nil
            userActionLabel.text = "??"
            opponentActionLabel.text = "??"
            userActionLabel.hidden = true
            opponentActionLabel.hidden = true
            middleActionLabel.text = ""
            battleActionContainer.hidden = false
            
            var array = [playerAttackValue, opponentDefenseValue]
            
            playerTurn = true
            
            updateUI()
            
            opponentCurrentHealth = opponentCurrentHealth - netDamage
            damageDealt = damageDealt + netDamage
            
            statShow1 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow:", userInfo: array, repeats: false)
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        appDelegate.avPlayer.play()
    }
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }
    
}


























