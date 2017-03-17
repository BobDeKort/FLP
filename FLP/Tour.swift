//
//  Tour.swift
//  FLP
//
//  Created by Bob De Kort on 2/16/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

public extension Sequence {
    func categorise<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = key(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
}

class Tour {
    
    var id: String
    var title: String
    var city: String
    var duration: String
    var description: String
    var category: String
    
    var price: Double
    var priceInCents: Double?
    
    var estimatedCost: Double?
    var estimatedCostInCents: Double?
    
    var nps: NSNumber?
    var averageRating: NSNumber?
    
    var user: String
    var stops: [String]?
    var reviews: [String]?
    
    var updated: String?
    
    // not on server
    var imageName: String
    
    init(id: String, title: String, city: String, duration: String, description: String, category: String, price: Double, estimatedCost: Double?, nps: NSNumber?, averageRating: NSNumber?, user: String, stops: [String]?, reviews: [String]?, imageName: String, updated: String?){
        self.id = id
        self.title = title
        self.city = city
        self.duration = duration
        self.description = description
        self.price = price
        self.estimatedCost = estimatedCost
        self.nps = nps
        self.averageRating = averageRating
        self.user = user
        self.stops = stops
        self.imageName = imageName
        self.reviews = reviews
        self.category = category
        
        self.updated = updated
    }
    
    convenience init?(json: [String: Any]) {
        guard let id = json["_id"] as? String else {
            print("no id in json")
            return nil
        }
        
        guard let title = json["title"] as? String else {
            print("no title in json")
            return nil
        }
        
        guard let city = json["city"] as? String else {
            print("no city in json")
            return nil
        }
        
        guard let duration = json["duration"] as? String else {
            print("no duration in json")
            return nil
        }
        
        guard let description = json["description"] as? String else {
            print("no description in json")
            return nil
        }
        
        guard let price = json["price"] as? Double else {
            print("no price in json")
            return nil
        }
        
        guard let category = json["category"] as? String else {
            print("no category")
            return nil
        }
        
        guard let user = json["user"] as? String else {
            print("no user in json ")
            return nil
        }
        
        guard let image = json["coverImgUrl"] as? String else {
            print("no image in json")
            return nil
        }
        
        guard let stops = json["stops"] as? [String] else {
            print("no stops")
            return nil
        }
        
        self.init(id: id, title: title, city: city, duration: duration, description: description, category: category, price: price, estimatedCost: nil, nps: nil, averageRating: nil, user: user , stops: stops, reviews: nil, imageName: image, updated: nil)
    }
}
