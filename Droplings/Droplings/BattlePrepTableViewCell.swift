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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
