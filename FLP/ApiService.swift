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
    
    let baseURL = "http://localhost:3000"
//    let baseURL = "http://10.146.44.89"
    
//    let baseRequest: URLRequest? = {
//        if let url = URL(string: "http://localhost:3000") {
//            var req = URLRequest(url: url)
//            
//            if let token = UserDefaults.standard.value(forKey: "user_auth_token") as? String {
//                req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            }
//            
//            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            return req
//        } else {
//            return nil
//        }
//    }()
//    
//    let baseUrl: URL? = {
//        if let url = URL(string: "http://localhost:3000") {
//            return url
//        }
//        
//        return nil
//    }()
    
    func login(email: String, password: String, completionHandler: @escaping (Bool)-> Void){
        let urlString = "\(baseURL)/login"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postString = "email=\(email)&password=\(password)"
            request.httpBody = postString.data(using: .utf8)
        
            Alamofire.request(request).responseJSON { response in
                
                guard response.result.error == nil else {
                    
                    print(response.result.error!)
                    completionHandler(false)
                    return
                }
                
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't get todo objects as JSON from API")
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
                    print("Succes")
                    print(token)
                    //TODO: Save Token to userdefaults
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
            let postString = "email=\(email)&password=\(password)&username=\(username)"
            request.httpBody = postString.data(using: .utf8)
            
            Alamofire.request(request).responseJSON { response in
                
                guard response.result.error == nil else {
                    
                    print(response.result.error!)
                    completionHandler(false)
                    return
                }
                
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't get todo objects as JSON from API")
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
                    print("Succes")
                    print(token)
                    //TODO: Save Token to userdefaults
                    let userDefaults = UserDefaults.standard
                    userDefaults.set(token, forKey: "user_auth_token")
                    completionHandler(true)
                }
            }
        }
    }
    
    func checkout(nonce: String){
        let url = "\(baseURL)/checkout"
        
        let parameters = ["paymentNonce" : nonce, "Content-Type" : "application/json"]
        
        Alamofire.request(url, method: .post, parameters: parameters,
                          encoding: URLEncoding.httpBody)
            .responseJSON { response in
            
            guard response.result.error == nil else {
                
                print(response.result.error!)
                
                return
            }
            
            guard let json = response.result.value as? [String: AnyObject] else {
                print("didn't get objects as JSON from API")
                
                return
            }
         
            print(json)
        }
    }
    
    func getProfile(completionHandler: @escaping ([Tour]) -> Void){
        let url = "\(baseURL)/profile"
        
        let token = UserDefaults.standard.value(forKey: "user_auth_token") as? String
        if let token = token {
            let header = [ "Content-Type" : "application/json", "Authorization" : "Bearer \(token)"]
            
            Alamofire.request(url, headers: header).responseJSON { response in
                
                guard response.result.error == nil else {
                    
                    print(response.result.error!)
                    
                    return
                }
                
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't get todo objects as JSON from API")
                    
                    return
                }
                
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
    }
    
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
        
        let ContentTypeheader = [ "Content-Type" : "application/json"]
        
        Alamofire.request(url, headers: ContentTypeheader).responseJSON { response in
            
            guard response.result.error == nil else {
                
                print(response.result.error!)
                
                return
            }
            
            guard let json = response.result.value as? [String: AnyObject] else {
                print("didn't get todo objects as JSON from API")
                
                return
            }
            
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
    
}
