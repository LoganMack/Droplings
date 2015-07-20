//
//  DroplingBase.swift
//  Droplings
//
//  Created by Logan McKinzie on 7/13/15.
//  Copyright (c) 2015 Logan McKinzie. All rights reserved.
//

import Foundation

class Dropling {
    
    // Name and Type
    var name: String = ""
    var type: String = ""
    
    // Base Stats
    var damage: Int = 0
    var defense: Int = 0
    var health: Int = 0
    var stamina: Int = 0
    var regen: Int = 0
    
    // Images
    var image: String = ""
    var imageHat: String = ""
    var imageShirt: String = ""
    
    // Equipable Item
    var equipment: Item? = nil
    
    
    // Initializer
    init() {
        
    }
    
    init(name: String, type: String, damage: Int, defense: Int, health: Int, stamina: Int, regen: Int, image: String, imageHat: String, imageShirt: String, equipment: Item) {
        
        self.name = name
        self.type = type
        
        self.damage = damage
        self.defense = defense
        self.health = health
        self.stamina = stamina
        self.regen = regen
        
        self.image = image
        self.imageHat = imageHat
        self.imageShirt = imageShirt
        
        self.equipment = equipment
    }
}
