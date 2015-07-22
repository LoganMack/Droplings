//
//  HelpVC.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class HelpVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let helpTopics: [HelpTopic] = [
        HelpTopic(name: "The Farm", desc: "Help getting started with growing and farming droplings at the farm.", image: "FIRE", fullText: "", helpImage1: "", helpImage2: "", helpImage3: "", helpImage4: ""),
        HelpTopic(name: "Battle Preperation", desc: "A quick tutorial on how to prepare for battle.", image: "FIRE", fullText: "", helpImage1: "", helpImage2: "", helpImage3: "", helpImage4: ""),
        HelpTopic(name: "The Arena - Basic Help", desc: "The basics of how to fight in the arena.", image: "FIRE", fullText: "", helpImage1: "", helpImage2: "", helpImage3: "", helpImage4: ""),
        HelpTopic(name: "The Arena - Advanced Help", desc: "Advanced topics and strategies related to battle.", image: "FIRE", fullText: "", helpImage1: "", helpImage2: "", helpImage3: "", helpImage4: ""),
        HelpTopic(name: "Droplings", desc: "Everything you need to know about your pets.", image: "Molten Dropling 1", fullText: "", helpImage1: "", helpImage2: "", helpImage3: "", helpImage4: "")]

    @IBOutlet weak var backButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = backButton.bounds.height * 0.4
        backButton.clipsToBounds = true
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpTopics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Recycle cells.
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuse, forIndexPath: indexPath) as! HelpTableViewCell;
        
        // Configure the cell.
        cell.topicTitle.text = helpTopics[indexPath.row].name
        cell.topicDesc.text = helpTopics[indexPath.row].desc
        cell.topicImage.image = UIImage(named: helpTopics[indexPath.row].image)
        cell.layer.cornerRadius = cell.bounds.height * 0.4
        cell.clipsToBounds = true
        return cell
    }

    @IBAction func backButtonTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}



