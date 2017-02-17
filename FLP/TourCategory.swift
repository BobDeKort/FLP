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
    var type: String?
    
    static func sampleData() -> [TourCategory]{
        
        
        
        let bestNewTours = TourCategory()
        bestNewTours.name = "Best New Tours"
        
        let tour = Tour(id: 1, name: "Best Tour Ever", category: "Food", imageName: "image1", price: 1.99, updated: "3 days ago", duration: "3hr")
        bestNewTours.tours = [tour, tour]
        
        let worstTours = TourCategory()
        worstTours.name = "Worst Tours"
        
        let tour2 = Tour(id: 2, name: "worst Tour", category: "Fun", imageName: "image2", price: 0.99, updated: "3 days ago", duration: "3hr")
        worstTours.tours = [tour2]
        
        let tourCategories: [TourCategory] = [bestNewTours, worstTours]
        
        return tourCategories
    }
    
    
}
