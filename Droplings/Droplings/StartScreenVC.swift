//
//  StartScreenVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit
import AVFoundation

class StartScreenVC: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var battle: UIView!
    @IBOutlet weak var farm: UIView!
    @IBOutlet weak var farmhouse: UIView!
    @IBOutlet weak var help: UIView!
    @IBOutlet weak var settings: UIView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileURL: NSURL = NSBundle.mainBundle().URLForResource("MenuMusic", withExtension: "mp3")!
        
        appDelegate.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: AVFileTypeMPEGLayer3, error: nil)
        
        appDelegate.avPlayer.delegate = self
        appDelegate.avPlayer.prepareToPlay()
        appDelegate.avPlayer.volume = 1.0
        
        appDelegate.avPlayer.play()
        
        
        battle.layer.cornerRadius = battle.bounds.height * 0.4
        farm.layer.cornerRadius = farm.bounds.height * 0.4
        farmhouse.layer.cornerRadius = farmhouse.bounds.height * 0.4
        help.layer.cornerRadius = help.bounds.height * 0.4
        settings.layer.cornerRadius = settings.bounds.height * 0.4
        
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        appDelegate.avPlayer.play()
    }
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }

}
