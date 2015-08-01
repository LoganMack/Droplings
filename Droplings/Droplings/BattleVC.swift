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
    
    // Variable used during animation.
    var bounceAnimationNormal = true
    
    // Variable used to grab the audio player from the app delegate later.
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // Audio player for the attack sound effect.
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
    
    // Used to change the attack button text when the user tries to do something they can't do.
    @IBOutlet weak var attackButtonText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grabs the battle music file.
        let fileURL: NSURL = NSBundle.mainBundle().URLForResource("BattleMusic", withExtension: "mp3")!
        
        // Gives the music to the audio player in the app delegate.
        appDelegate.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
        
        // Some setup for the audio player.
        appDelegate.avPlayer.delegate = self
        appDelegate.avPlayer.prepareToPlay()
        appDelegate.avPlayer.volume = 1.0
        
        // Playing the music.
        appDelegate.avPlayer.play()
        
        // Grabs the attack sound effect.
        let fileURLAttack: NSURL = NSBundle.mainBundle().URLForResource("Punch3", withExtension: "mp3")!
        
        // Same as above, gives the sound effect to the sound effect player, and then we do some setup.
        attackSoundPlayer = AVAudioPlayer(contentsOfURL: fileURLAttack, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
        
        attackSoundPlayer.delegate = nil
        attackSoundPlayer.prepareToPlay()
        attackSoundPlayer.volume = 1.0
        
        // Starts the bouncing animation.
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
        
        // Updates the UI to all of these initial values.
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
    /// This function fades the view from black to white over the course of a few seconds, when it is first loaded. It also randomly selects which player gets to go first, and starts their turn.
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
    
    /// This function updates the basic stats UI for both players, can be called at anytime to update all important UI elements.
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
    
    /// This function manages the bouncing animation done by the droplings throughout the battle. It is called every 1.5 seconds(by a timer in the viewDidLoad), and simply changes the image for each dropling to an alternate, to make it appear like they are bouncing.
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
    
    /// Simply changes the text of the attack button back to ATTACK after it was changed to alert the user of something.
    func revertAttackText () {
        attackButtonText.text = "ATTACK"
        attackContainer.userInteractionEnabled = true
    }
    
    /// This function runs when it is the player's turn.
    func battlePlayerTurn () {
        
        // First we hide the container for attack info and unhide the skills selector(actionContainer).
        view.userInteractionEnabled = false
        actionContainer.hidden = false
        battleActionContainer.hidden = true
        updateUI()
        
        // Next we check to see if the opponent has died. If they have, we stop the battle and declare the player the winner.
        if opponentCurrentHealth <= 0 {
            playerVictory()
            return
        }
        
        // Now we check to see if the player has any buffs on them. If they do, we need to change their stats accordingly, and then reduce the buff/nerf time by one.
        if playerBuffTime > 0 || playerNerfTime > 0 {
            playerCurrentHealth = playerCurrentHealth + playerBuffHealth + playerNerfHealth
            playerCurrentStamina = playerCurrentStamina + playerBuffStamina + playerNerfStamina
            playerCurrentDamage = playerOriginalDamage + playerBuffDamage + playerNerfDamage
            playerCurrentDefense = playerOriginalDefense + playerBuffDefense + playerNerfDefense
            playerCurrentRegen = playerOriginalRegen + playerBuffRegen + playerNerfRegen
            
            --playerBuffTime
            --playerNerfTime
        }
        
        // Now we regenerate some of the player's stamina.
        playerCurrentStamina = playerCurrentStamina + playerCurrentRegen
        
        // With these two checks we make sure the player's health and stamina don't go over their maximums.
        if playerCurrentStamina > playerMaxStamina {
            playerCurrentStamina = playerMaxStamina
        }
        
        if playerCurrentHealth > playerMaxHealth {
            playerCurrentHealth = playerMaxHealth
        }
        
        updateUI()
        
        // Now we make sure a nerf hasn't killed the player.
        if playerCurrentHealth <= 0 {
            opponentVictory()
            return
        }
        
        view.userInteractionEnabled = true
        
    }
    
    /// Runs when it is the opponent's turn.
    func battleOpponentTurn () {
        
        view.userInteractionEnabled = false
        updateUI()
        
        // We check to see if the player has died, then if the opponent has died.
        if playerCurrentHealth <= 0 {
            opponentVictory()
            return
        }
        
        updateUI()
        
        if opponentCurrentHealth <= 0 {
            playerVictory()
            return
        }
        
        // Now we select a skill for the opponent.
        opponentSkillSelector()
        
        view.userInteractionEnabled = true
        
    }
    
    /// Chooses a skill for the opponent.
    func opponentSkillSelector() {
        
        // We pick a random number between 0 and 5 for the skill/item to select.
        aiSkillSelector = Int(arc4random_uniform(4))
        
        // Here we make sure that the opponent doesn't spend forever trying to pick something even if it can't afford to use the skill. So after a few attempts, the opponent gives up and just attacks.
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
    
    /// Called when the opponent attacks the player.
    func opponentAttack() {
        
        // First we check if the number rolled was below 4. If it was, we can loop through all skills and apply its effects to the player(if it affects the opponent). If not, we apply the item's buffs to the opponent instead.
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
        
        // Now we also make sure the opponent's buffs and debuffs affect their damage, defense, and stamina regeneration.
        opponentCurrentDamage = opponentOriginalDamage + opponentBuffDamage + opponentNerfDamage
        opponentCurrentDefense = opponentOriginalDefense + opponentBuffDefense + opponentNerfDefense
        opponentCurrentRegen = opponentOriginalRegen + opponentBuffRegen + opponentNerfRegen
        
        // Next we roll a value for the opponent's attack and the player's defense, and add the opponent's damage and player's defense to those values.
        var opponentAttackValue = Int(arc4random_uniform(15)) + opponentCurrentDamage
        var playerDefenseValue = Int(arc4random_uniform(15)) + playerCurrentDefense
        
        // And we calculate the net damage based on that.
        var netDamage = opponentAttackValue - playerDefenseValue
        
        updateUI()
        
        // Making sure some attack statistics are properly hidden.
        playerTurn = false
        userActionImage.image = nil
        opponentActionImage.image = nil
        userActionLabel.text = "??"
        opponentActionLabel.text = "??"
        userActionLabel.hidden = true
        opponentActionLabel.hidden = true
        middleActionLabel.text = ""
        
        // Here we check if the damage done was greater than zero. If it was, we change the player's health accordingly. Either way, we send an array containing the damage and defense values into an NSTimer and a selector.
        if netDamage <= 0 {
            battleActionContainer.hidden = false
            
            var array = [playerDefenseValue, opponentAttackValue]
            
            statShow1 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow:", userInfo: array, repeats: false)
            
        } else {
            playerCurrentHealth = playerCurrentHealth - netDamage
            damageRecieved = damageRecieved + netDamage
            
            battleActionContainer.hidden = false
            
            var array = [playerDefenseValue, opponentAttackValue]
            
            statShow1 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow:", userInfo: array, repeats: false)
        }
        
    }
    
    /// This is the first in a series of functions that manage the animation showing how much damage was dealt, and how much of its damage was eliminated with defense.
    func statShow (timer: NSTimer) {
        
        // Empty array that will be given the array from the NSTimer's userInfo.
        var array: [Int] = []
        
        // First we check who's turn it is. Then we give the attack the "attack" image, and the defender the "defense" image. Then we show the attack and defense values to the user.
        if playerTurn {
            userActionImage.image = UIImage(named: "attack")
            opponentActionImage.image = UIImage(named: "defense")
            userActionLabel.hidden = false
            opponentActionLabel.hidden = false
            
            // Casting the array into an array of Ints.
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
        
        // Setting up the attack animation by grabbing the original location of each image.
        var imageLocation = self.playerDroplingImage.frame
        var imageOpponentLocation = self.opponentDroplingImage.frame
        
        // Now we check who is attacking, and then perform the attack animation for the attacker.
        if playerTurn {
            
            // We use a UIView.animateWithDuration to animate the image view.
            UIView.animateWithDuration(1, delay: 2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                // We have to move everything. The hat, shirt, and dropling itself.
                self.playerDroplingImage.frame = self.opponentDroplingImage.frame
                self.playerHat.frame = self.opponentDroplingImage.frame
                self.playerShirt.frame = self.opponentDroplingImage.frame
                
                // Upon completion, we run this code, which returns everything to its original position.
                }, completion: {finished in UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.playerDroplingImage.frame = imageLocation
                    self.playerHat.frame = imageLocation
                    self.playerShirt.frame = imageLocation}, completion: nil)})
            
        } else {
            
            UIView.animateWithDuration(1, delay: 2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.opponentDroplingImage.frame = self.playerDroplingImage.frame
                
                }, completion: {finished in UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {self.opponentDroplingImage.frame = imageOpponentLocation}, completion: nil)})
        }
        
        // Now we start the next phase of the attack animation, after 3 seconds.
        statShowNext2 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow2:", userInfo: array, repeats: false)
    }
    
    /// Second phase of attack animation.
    func statShow2 (timer: NSTimer) {
        
        // We play the attack sound effect. This is timed to happen at the same moment the attack animation makes the attacker hit the defender.
        attackSoundPlayer.play()
        
        // Another empty array for userInfo.
        var array: [Int] = []
        
        array = timer.userInfo as! [Int]
        
        // Here we subtract the numbers from each other to show how much more damage there was than defense, or vice versa.
        userActionLabel.text = "\(array[0] - array[1])"
        opponentActionLabel.text = "\(array[1] - array[0])"
        
        // Making sure we don't show negative numbers here.
        if array[0] - array[1] < 0 {
            userActionLabel.text = "0"
        }
        
        if array[1] - array[0] < 0 {
            opponentActionLabel.text = "0"
        }
        
        updateUI()
        
        // Setting up the final phase.
        statShowNext3 = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "statShow3", userInfo: nil, repeats: false)
    }
    
    /// Phase three of the attack animation. All we do is update the UI and then start the next player's turn.
    func statShow3 () {
        
        updateUI()
        
        if playerTurn {
            battleOpponentTurn()
        } else {
            battlePlayerTurn()
        }
        
        
    }
    
    /// Runs if the player wins. Simply segues to the battle stats screen.
    func playerVictory () {
        victory = true
        appDelegate.avPlayer.stop()
        performSegueWithIdentifier("end", sender: self)
    }
    
    /// Runs if the opponent wins. Simply segues to the battle stats screen.
    func opponentVictory () {
        victory = false
        appDelegate.avPlayer.stop()
        performSegueWithIdentifier("end", sender: self)
    }
    
    
    // MARK: - @IBActions
    // Tap Gesture Recognizers
    // These send the skill that was tapped to a variable, selectedAttackIndex, to determine which skill to use. They also give the selected skill a border and border color, so it is easy to tell what is selected.
    @IBAction func skill1Tap(sender: UITapGestureRecognizer) {
        if selectedAttack == sender.view {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = nil
            
        } else if selectedAttack != nil {
            selectedAttack?.layer.borderWidth = 0
            
            selectedAttack = sender.view
            
            // If the skill affects the opponent, its border color needs to be yellow to match the background. Otherwise, it'll be blue.
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
    
    // This is triggered if the user taps on the item instead. It functionally does the same thing as the skill taps.
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
    
    // A lot of this is the same stuff that happens in opponentAttack(), but there is more meat in here because the user is doing it, not the CPU. This is triggered when the player taps the attack button.
    @IBAction func attackTap(sender: UITapGestureRecognizer) {
        if selectedAttack != nil {
            
            // Checks if we selected an item or a skill(skills have indexes lower than 4, the item's index is 4).
            if selectedAttackIndex < 4 {
                
                // We have to make sure the player has the stamina(or health) to use this skill. If they don't, we give them an alert of sorts by changing the attack button's text to a warning for 2 seconds.
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
                    
                    // If they can afford the skill, we then check if it affects their opponent or not, and change the opponents/player's stats accordingly. We also subtract the stamina/health cost of the skill from the player's current stamina/health.
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
                
                // Stat tracking, woohoo.
                ++skillsUsed
                
                // If they choose the item, we run this instead. It uses the item's stats instead, and then hides the item's view so it can't be used twice.
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
        
        // Applies buff and nerf stats.
        playerCurrentDamage = playerOriginalDamage + playerBuffDamage + playerNerfDamage
        playerCurrentDefense = playerOriginalDefense + playerBuffDefense + playerNerfDefense
        playerCurrentRegen = playerOriginalRegen + playerBuffRegen + playerNerfRegen
        
        // Next we roll a value for the opponent's attack and the player's defense, and add the opponent's damage and player's defense to those values.
        var playerAttackValue = Int(arc4random_uniform(15)) + playerCurrentDamage
        var opponentDefenseValue = Int(arc4random_uniform(15)) + opponentCurrentDefense
        
        // And we calculate the net damage based on that.
        var netDamage = playerAttackValue - opponentDefenseValue
        
        updateUI()
        
        userActionImage.image = nil
        opponentActionImage.image = nil
        userActionLabel.text = "??"
        opponentActionLabel.text = "??"
        userActionLabel.hidden = true
        opponentActionLabel.hidden = true
        middleActionLabel.text = ""
        
        // Here we check if the damage done was greater than zero. If it was, we change the player's health accordingly. Either way, we send an array containing the damage and defense values into an NSTimer and a selector.
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
    
    // This just loops the music.
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        appDelegate.avPlayer.play()
    }
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }
    
}


























