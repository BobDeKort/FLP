//
//  User.swift
//  FLP
//
//  Created by Bob De Kort on 3/9/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

class User {
    var email: String
    var firstName: String
    var lastName: String
    var reviews: [Review]?
    var tours: [Tour]?
    var purchasedTours: [Tour]?
    
    init(email: String, first: String, last: String, reviews: [Review]?, tours: [Tour]?, purchasedTours: [Tour]?) {
        self.email = email
        self.firstName = first
        self.lastName = last
        self.reviews = reviews
        self.tours = tours
        self.purchasedTours = purchasedTours
    }
    
    convenience init?(json: [String: Any]) {
        guard let email = json["email"] as? String,
            let first = json["first"] as? String,
            let last = json["last"] as? String,
            let reviewsJson = json["reviews"] as? [[String: AnyObject]],
            let toursJson = json["tours"] as? [[String: AnyObject]],
            let purchasedToursJson = json["purchasedTours"] as? [[String: AnyObject]]
            else {
                print("Something went wrong parsing a User")
                return nil
        }
        
        let reviews = reviewsJson.flatMap({Review(json: $0)})
        let tours = toursJson.flatMap({Tour(json: $0)})
        let purchasedTours = purchasedToursJson.flatMap({Tour(json: $0)})
        self.init(email: email, first: first, last: last, reviews: reviews, tours: tours, purchasedTours: purchasedTours)
    }
    
}
