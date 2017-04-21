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
    var description: String
    var imageUrls: [String]?
    
    var userId: String
    var tourId: String
    
    init(title: String, place: String, address: String, summary: String, userId: String, tourId: String, imageUrls: [String]?) {
        self.title = title
        self.place = place
        self.address = address
        self.description = summary
        self.userId = userId
        self.tourId = tourId
        self.imageUrls = imageUrls
    }
    
    convenience init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let place = json["place"] as? String,
            let address = json["address"] as? String,
            let summary = json["summary"] as? String,
            let userId = json["user"] as? String,
            let tourjson = json["tour"] as? [String: Any],
            let tourId = tourjson["_id"] as? String,
            let urlString = json["imgUrls"] as? [String]
            else {
                print("Something went wrong parsing a Stop")
                return nil
        }
        
        var imageUrls: [String] = []
        
        if urlString.count == 1 {
            let smallImageUrls = urlTransformation.seperateUrlsByComma(urlString: urlString[0])
            imageUrls = urlTransformation.enlargeUrlrequestImages(urls: smallImageUrls, width: 600)
        } else {
            imageUrls = urlString
        }
        
        self.init(title: title, place: place, address: address, summary: summary, userId: userId, tourId: tourId, imageUrls: imageUrls)
    }
}
