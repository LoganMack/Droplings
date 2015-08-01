//
//  BattleStatsVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit
import AVFoundation

class BattleStatsVC: UIViewController, AVAudioPlayerDelegate {
    
    // These variables will hold stats that will get passed in.
    var victory = true
    var damageDealt = 0
    var damageRecieved = 0
    var staminaUsed = 0
    var skillsUsed = 0
    
    // Link to the app delegate(for the music player).
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var victoryLabel: UILabel!
    @IBOutlet weak var damageDealtLabel: UILabel!
    @IBOutlet weak var damageRecievedLabel: UILabel!
    @IBOutlet weak var staminaUsedLabel: UILabel!
    @IBOutlet weak var skillsUsedLabel: UILabel!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var newBattleButton: UIView!
    @IBOutlet weak var mainMenuButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up the music again.
        var fileURL: NSURL = NSBundle.mainBundle().URLForResource("VictoryMusic", withExtension: "mp3")!
        
        // If the user lost, we need to change the music to the sad music. Losers don't get happy music.
        if victory == false {
            fileURL = NSBundle.mainBundle().URLForResource("LoseMusic", withExtension: "mp3")!
        }
        
        appDelegate.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
        
        appDelegate.avPlayer.delegate = self
        appDelegate.avPlayer.prepareToPlay()
        appDelegate.avPlayer.volume = 1.0
        
        appDelegate.avPlayer.play()
        
        // More rounded corners!
        container.layer.cornerRadius = container.bounds.height * 0.4
        newBattleButton.layer.cornerRadius = newBattleButton.bounds.height * 0.4
        mainMenuButton.layer.cornerRadius = mainMenuButton.bounds.height * 0.4
        
        // Giving stats to labels.
        damageDealtLabel.text = "Damage Dealt: \(damageDealt)"
        damageRecievedLabel.text = "Damage Taken: \(damageRecieved)"
        staminaUsedLabel.text = "Stamina Used: \(staminaUsed)"
        skillsUsedLabel.text = "Skills Used: \(skillsUsed)"

        // Checking if the user won or not, and then telling them.
        if victory {
            victoryLabel.text = "Victory!"
        } else {
            victoryLabel.text = "Defeat!"
        }
    }
    
    // Prepping for two different segways here using optional binding. All these do is make sure the music starts to play no matter where we go.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        appDelegate.avPlayer.stop()
        
        if let dVC = segue.destinationViewController as? BattlePrepVC {
            var fileURL: NSURL = NSBundle.mainBundle().URLForResource("MenuMusic", withExtension: "mp3")!
            appDelegate.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
            appDelegate.avPlayer.prepareToPlay()
            appDelegate.avPlayer.play()
            
        } else if let dVC = segue.destinationViewController as? StartScreenVC {
            var fileURL: NSURL = NSBundle.mainBundle().URLForResource("MenuMusic", withExtension: "mp3")!
            appDelegate.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
            appDelegate.avPlayer.prepareToPlay()
            appDelegate.avPlayer.play()
        }
    }
    
    // Looping that music.
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        appDelegate.avPlayer.play()
    }
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }

}
