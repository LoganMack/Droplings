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
    
    var victory = true
    var damageDealt = 0
    var damageRecieved = 0
    var staminaUsed = 0
    var skillsUsed = 0
    
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
        
        var fileURL: NSURL = NSBundle.mainBundle().URLForResource("VictoryMusic", withExtension: "mp3")!
        
        if victory == false {
            fileURL = NSBundle.mainBundle().URLForResource("LoseMusic", withExtension: "mp3")!
        }
        
        appDelegate.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
        
        appDelegate.avPlayer.delegate = self
        appDelegate.avPlayer.prepareToPlay()
        appDelegate.avPlayer.volume = 1.0
        
        appDelegate.avPlayer.play()
        
        container.layer.cornerRadius = container.bounds.height * 0.4
        newBattleButton.layer.cornerRadius = newBattleButton.bounds.height * 0.4
        mainMenuButton.layer.cornerRadius = mainMenuButton.bounds.height * 0.4
        
        damageDealtLabel.text = "Damage Dealt: \(damageDealt)"
        damageRecievedLabel.text = "Damage Taken: \(damageRecieved)"
        staminaUsedLabel.text = "Stamina Used: \(staminaUsed)"
        skillsUsedLabel.text = "Skills Used: \(skillsUsed)"

        if victory {
            victoryLabel.text = "Victory!"
        } else {
            victoryLabel.text = "Defeat!"
        }
    }
    
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
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        appDelegate.avPlayer.play()
    }
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }

}
