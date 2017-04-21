//
//  Review.swift
//  FLP
//
//  Created by Bob De Kort on 3/9/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

class Review {
    var id: String
    var title: String
    var content: String
    var rating: NSNumber
    var user: String
    var tour: String
    
    init(id: String, title: String, content: String, rating: NSNumber, user: String, tour: String) {
        self.id = id
        self.title = title
        self.content = content
        self.rating = rating
        self.user = user
        self.tour = tour
    }
    
    convenience init?(json: [String: Any]) {
        guard let id = json["_id"] as? String,
            let title = json["title"] as? String,
            let content = json["content"] as? String,
            let rating = json["rating"] as? NSNumber,
            let user = json["user"] as? String,
            let tour = json["tour"] as? String
            else {
                print("Something went wrong parsing a Review")
                return nil
        }
        
        self.init(id: id, title: title, content: content, rating: rating, user: user, tour: tour)
    }
}
