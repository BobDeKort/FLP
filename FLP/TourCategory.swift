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
        
        let tour = Tour(id: 1, name: "Best Tour Ever", category: "Food", description: "Offices parties lasting outward nothing age few resolve. Impression to discretion understood to we interested he excellence. Him remarkably use projection collecting. Going about eat forty world has round miles. Attention affection at my preferred offending shameless me if agreeable. Life lain held calm and true neat she. Much feet each so went no from. Truth began maids linen an mr to after. Offices parties lasting outward nothing age few resolve. Impression to discretion understood to we interested he excellence. Him remarkably use projection collecting. Going about eat forty world has round miles. Attention affection at my preferred offending shameless me if agreeable. Life lain held calm and true neat she. Much feet each so went no from. Truth began maids linen an mr to after.", imageName: "image1", price: 1.99, updated: "3 days ago", duration: "3hr")
        bestNewTours.tours = [tour, tour]
        
        let worstTours = TourCategory()
        worstTours.name = "Worst Tours"
        
        let tour2 = Tour(id: 2, name: "worst Tour", category: "Fun", description: "Can curiosity may end shameless explained. True high on said mr on come. An do mr design at little myself wholly entire though. Attended of on stronger or mr pleasure. Rich four like real yet west get. Felicity in dwelling to drawings. His pleasure new steepest for reserved formerly disposed jennings. ", imageName: "image2", price: 0.00, updated: "3 days ago", duration: "3hr")
        worstTours.tours = [tour2]
        
        let worstTours2 = TourCategory()
        worstTours.name = "Worst Tours"
        
        let tour3 = Tour(id: 2, name: "worst Tour", category: "Fun", description: "Can curiosity may end shameless explained. True high on said mr on come. An do mr design at little myself wholly entire though. Attended of on stronger or mr pleasure. Rich four like real yet west get. Felicity in dwelling to drawings. His pleasure new steepest for reserved formerly disposed jennings. ", imageName: "image2", price: 0.00, updated: "3 days ago", duration: "3hr")
        worstTours2.tours = [tour3]
        
        let tourCategories: [TourCategory] = [bestNewTours, worstTours, worstTours2]
        
        return tourCategories
    }
    
    
}
