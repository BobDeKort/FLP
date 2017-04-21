//
//  ApiService.swift
//  FLP
//
//  Created by Bob De Kort on 3/8/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    
    static var sharedInstance = ApiService()
    static var categories: [String]?
    
//    let baseURL = "http://localhost:3000"
    let baseURL = "http://www.goplanyt.com"
    
    // MARK: Profile
    
    func getPurchasedTours(completionHandler: @escaping ([Tour]) -> Void){
        let url = "\(baseURL)/profile"
        
        authenticatedRequest(url: url) { (json) in
            if let user = json["user"] {
                if let purchasedTours = user["purchasedTours"] as? [[String: AnyObject]]{
                    var tours: [Tour] = []
                    for i in purchasedTours {
                        let tour = Tour(json: i)
                        if let tour = tour {
                            tours.append(tour)
                        }
                    }
                    completionHandler(tours)
                }
            }
        }
    }
    
    // MARK: Tours
    
    func getTourCategories(completionHandler: @escaping ([TourCategory])->()){
        let url = "\(baseURL)/tours"
        
        var tourCategories: [TourCategory] = []
        var categoryNames: [String] = []
        getTours(url: url) { (tours) in
            if tours.count != 0{
                let dict = tours.categorise{ $0.category }
                
                for i in dict {
                    tourCategories.append(TourCategory(name: i.key, tours: i.value))
                    categoryNames.append(i.key)
                }
                ApiService.categories = categoryNames
                completionHandler(tourCategories)
            }
        }
    }
    
    func getTours(url: String, completionHandler: @escaping ([Tour]) -> ()){
        
        authenticatedRequest(url: url) { (json) in
            var tours: [Tour] = []
            
            if let toursJson = json["tours"] as? [[String: AnyObject]] {
                for tour in toursJson {
                    let tour = Tour(json: tour)
                    if let tour = tour {
                        tours.append(tour)
                    }
                }
            }
            completionHandler(tours)
        }
    }
    
    // MARK: Stops
    
    func getStops(tourId: String, stopIds: [String], completionHandler: @escaping ([Stop]) -> ()){
        var stops: [Stop] = []
        
        for stopId in stopIds {
            getStop(tourId: tourId, stopId: stopId, completionHandler: { (stop) in
                stops.append(stop)
                if stops.count == stopIds.count {
                    completionHandler(stops)
                }
            })
        }
    }
    
    func getStop(tourId: String, stopId: String, completionHandler: @escaping (Stop) -> () ){
        let url = "\(baseURL)/tours/\(tourId)/stops/\(stopId)"
        
        authenticatedRequest(url: url) { (json) in
            let stop = Stop(json: json["stop"] as! [String : Any])
            if let stop = stop {
                completionHandler(stop)
            } else {
                print("Did not get a stop")
            }
            
            
        }
    }
    
    // MARK: Reviews
    
    func getReviews(tourId: String, reviewIds: [String], completionHandler: @escaping ([Review]) -> ()){
        var reviews: [Review] = []
        for reviewId in reviewIds {
            getReview(tourId: tourId, reviewId: reviewId, completionHandler: { (review) in
                reviews.append(review)
                if reviews.count == reviewIds.count {
                    completionHandler(reviews)
                }
            })
        }
    }
    
    func getReview(tourId: String, reviewId: String, completionHandler: @escaping (Review) -> ()){
        let url = "\(baseURL)/tours/\(tourId)/reviews/\(reviewId)"
        
        authenticatedRequest(url: url) { (json) in
            let review = Review(json: json["review"] as! [String : Any])
            if let review = review {
                completionHandler(review)
            } else {
                print("no review in json")
            }
        }
    }
    
    func postReview(tourId: String, review: ReviewStruct, completion: @escaping (Bool) -> Void){
        let urlString = "\(baseURL)/tours/\(tourId)/reviews"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let token = UserDefaults.standard.value(forKey: "user_auth_token") as? String
            if let token = token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let postString = "title=\(review.title)&content=\(review.content)&rating=\(review.rating.roundTo(places: 2))"
                request.httpBody = postString.data(using: .utf8)
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                Alamofire.request(request).responseJSON { response in
                    
                    guard response.result.error == nil else {
                        
                        print(response.result.error!)
                        completion(false)
                        return
                    }
                    
                    guard ((response.result.value as? [String: AnyObject]) != nil) else {
                        print("didn't get review")
                        completion(false)
                        return
                    }
                    
                    completion(true)
                }
            }
        }
    }
    
    // MARK: Payment
    
    func getClientToken(completion: @escaping (String) -> Void) {
        let url = "\(baseURL)/client-token"
        authenticatedRequest(url: url) { (json) in
            if let token = json["clientToken"] as? String {
                completion(token)
            } else {
                print("no client token received")
            }
        }
    }
    
    func purchaseTour(nonce: String, tourId: String){
        let url = "\(baseURL)/tours/\(tourId)/purchase"
        
        if let url = URL(string: url) {
            let token = UserDefaults.standard.value(forKey: "user_auth_token") as? String
            if let token = token {
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let postString = "nonce=\(nonce)"
                request.httpBody = postString.data(using: .utf8)
                
                Alamofire.request(request).responseJSON { response in
                    
                    guard response.result.error == nil else {
                        
                        print(response.result.error!)
                        
                        return
                    }
                    
                    guard let json = response.result.value as? [String: AnyObject] else {
                        print("didn't purchase")
                        
                        return
                    }
                    
                    // TODO: Handel new tour purchase
                    print(json)
                }
            }
        }
    }
    
    // MARK: General Functions
    
    func authenticatedRequest(url: String, completion: @escaping ([String: AnyObject]) -> ()){
        
        let token = UserDefaults.standard.value(forKey: "user_auth_token") as? String
        if let token = token {
            let header = [ "Content-Type" : "application/json", "Authorization" : "Bearer \(token)"]
            
            Alamofire.request(url, headers: header).responseJSON { response in
                
                guard response.result.error == nil else {
                    
                    print(response.result.error!)
                    
                    return
                }
                
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't get json")
                    
                    return
                }
                
                completion(json)
            }
        }
    }
    
    // MARK: Login
    
    func login(email: String, password: String, completionHandler: @escaping (Bool)-> Void){
        let urlString = "\(baseURL)/login"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postString = "email=\(email)&password=\(password)"
            request.httpBody = postString.data(using: .utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            Alamofire.request(request).responseJSON { response in
                
                guard response.result.error == nil else {
                    
                    print(response.result.error!)
                    completionHandler(false)
                    return
                }
                
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't login")
                    completionHandler(false)
                    return
                }
                
                if let message = json["message"] as? String {
                    print(message)
                    //TODO: Show alert
                    completionHandler(false)
                    return
                }
                
                if let token = json["token"] as? String {
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(token, forKey: "user_auth_token")
                    completionHandler(true)
                }
                
            }
        }
    }
    
    func signUp(email: String, password: String, username: String, completionHandler: @escaping (Bool)-> Void){
        let urlString = "\(baseURL)/sign-up"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postString = "username=\(username)&email=\(email)&password=\(password)"
            request.httpBody = postString.data(using: .utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            Alamofire.request(request).responseJSON { response in
                
                guard response.result.error == nil else {
                    
                    print(response.result.error!)
                    completionHandler(false)
                    return
                }
                
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't signup")
                    completionHandler(false)
                    return
                }
                
                if let message = json["message"] as? String {
                    print(message)
                    //TODO: Show alert
                    completionHandler(false)
                    return
                }
                
                if let token = json["token"] as? String {
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(token, forKey: "user_auth_token")
                    completionHandler(true)
                }
                
                completionHandler(false)
            }
        }
    }
}
