//
//  Review.swift
//  FLP
//
//  Created by Bob De Kort on 3/9/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

class Review {
    var title: String
    var content: String
    var rating: NSNumber
    var user: User
    var tour: Tour
    
    init(title: String, content: String, rating: NSNumber, user: User, tour: Tour) {
        self.title = title
        self.content = content
        self.rating = rating
        self.user = user
        self.tour = tour
    }
    
    convenience init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let content = json["content"] as? String,
            let rating = json["rating"] as? NSNumber,
            let userJson = json["user"] as? [String: Any],
            let tourJson = json["tour"] as? [String: Any],
            let user = User(json: userJson),
            let tour = Tour(json: tourJson)
            else {
                print("Something went wrong parsing a Review")
                return nil
        }
        
        self.init(title: title, content: content, rating: rating, user: user, tour: tour)
    }
}
