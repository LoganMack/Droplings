//
//  CustomTableViewCell.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/15/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class BattlePrepTableViewCell: UITableViewCell {
    
    // Cell Outlets
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var damage: UILabel!
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var regen: UILabel!
    @IBOutlet weak var stamina: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var healthCost: UILabel!
    @IBOutlet weak var staminaCost: UILabel!
    @IBOutlet weak var timeCost: UILabel!
    
    @IBOutlet weak var highStatContainer: UIView!
    @IBOutlet weak var lowStatContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        highStatContainer.layer.cornerRadius = highStatContainer.bounds.height * 0.4
        lowStatContainer.layer.cornerRadius = highStatContainer.bounds.height * 0.4
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
