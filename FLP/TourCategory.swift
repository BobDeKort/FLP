//
//  TourCategory.swift
//  FLP
//
//  Created by Bob De Kort on 2/16/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

class TourCategory {
    
    var name: String?
    var tours: [Tour]?
    
    init(name: String, tours: [Tour]?) {
        self.name = name
        self.tours = tours
    }
}
