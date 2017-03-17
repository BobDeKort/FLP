//
//  Stop.swift
//  FLP
//
//  Created by Bob De Kort on 3/9/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

class Stop {
    var title: String
    var place: String
    var address: String
    var summary: String
    
    var user: User
    var tour: Tour
    
    init(title: String, place: String, address: String, summary: String, user: User, tour: Tour) {
        self.title = title
        self.place = place
        self.address = address
        self.summary = summary
        self.user = user
        self.tour = tour
    }
    
    convenience init?(json: [String: Any]) {
        guard let title = json["tilte"] as? String,
            let place = json["place"] as? String,
            let address = json["address"] as? String,
            let summary = json["summary"] as? String,
            let userJson = json["user"] as? [String : Any],
            let tourJson = json["tour"] as? [String: Any],
            let user = User(json: userJson),
            let tour = Tour(json: tourJson)
            else {
                print("Something went wrong parsing a Stop")
                return nil
        }
        self.init(title: title, place: place, address: address, summary: summary, user: user, tour: tour)
    }
}
