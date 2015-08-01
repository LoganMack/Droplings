//
//  HelpTopic.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/20/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import Foundation

// Unused for now.
class HelpTopic {
    
    var name = ""
    var desc = ""
    var image = ""
    
    var fullText = ""
    
    var helpImage1 = ""
    var helpImage2 = ""
    var helpImage3 = ""
    var helpImage4 = ""
    
    init () {
        
    }
    
    init (name: String, desc: String, image: String, fullText: String, helpImage1: String, helpImage2: String, helpImage3: String, helpImage4: String) {
        
        self.name = name
        self.desc = desc
        self.image = image
        
        self.fullText = fullText
        
        self.helpImage1 = helpImage1
        self.helpImage2 = helpImage2
        self.helpImage3 = helpImage3
        self.helpImage4 = helpImage4
        
    }
}