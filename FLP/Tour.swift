//
//  Tour.swift
//  FLP
//
//  Created by Bob De Kort on 2/16/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

class Tour {
    var id: Int
    var name: String
    var category: String
    var description: String
    var updated: String
    var duration: String
    var imageName: String
    var price: Double
    
    init(id: Int, name: String, category: String, description: String,  imageName: String, price: Double, updated: String, duration: String) {
        self.id = id
        self.name = name
        self.category = category
        self.description = description
        self.updated = updated
        self.duration = duration
        self.imageName = imageName
        self.price = price
    }
}
