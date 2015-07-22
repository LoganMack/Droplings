//
//  HelpTableViewCell.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var topicDesc: UILabel!
    @IBOutlet weak var topicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
