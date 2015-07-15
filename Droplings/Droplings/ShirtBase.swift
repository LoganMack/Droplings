//
//  ShirtBase.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/15/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import Foundation

class Shirt {
    
    // Name and Desc
    var name: String = ""
    var desc: String = ""
    
    // Base Stats
    var damage: Int = 0
    var defense: Int = 0
    var health: Int = 0
    var stamina: Int = 0
    var regen: Int = 0
    
    // Image
    var image: String = ""
    
    
    // Initializer
    init() {
        
    }
    
    init(name: String, desc: String, damage: Int, defense: Int, health: Int, stamina: Int, regen: Int, image: String) {
        
        self.name = name
        self.desc = desc
        
        self.damage = damage
        self.defense = defense
        self.health = health
        self.stamina = stamina
        self.regen = regen
        
        self.image = image
    }
}