//
//  TourDetailHeader.swift
//  FLP
//
//  Created by Bob De Kort on 2/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit
import BraintreeDropIn
import Braintree

class TourDetailHeader: BaseCell {
    
    var parent: UIViewController?
    
    var tour: Tour?{
        didSet{
            if let tour = tour {
                nameLabel.text = tour.title
                buyButton.setTitle("$\(tour.price)", for: .normal)
                
//                creatorLabel.text = "\(tour.user.firstName) + \(tour.user.lastName)"
                if let updated = tour.updated {
                    updatedLabel.text = updated
                }
                
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "image2")
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let creatorLabel: UILabel = {
        let label = UILabel()
        label.text = "by Test"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.3, alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.text = "duration: 3hr"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.3, alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let updatedLabel: UILabel = {
        let label = UILabel()
        label.text = "updated: 3 days ago"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.3, alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: UIControlState())
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()

    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(nameLabel)
        
        addSubview(creatorLabel)
        addSubview(durationLabel)
        addSubview(updatedLabel)
        
        addSubview(buyButton)
        
        addConstraintsWithFormat("H:|-14-[v0(125)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("H:|-14-[v0]-8-[v1]|", views: imageView, creatorLabel)
        addConstraintsWithFormat("H:|-14-[v0]-8-[v1]|", views: imageView, durationLabel)
        addConstraintsWithFormat("H:|-14-[v0]-8-[v1]|", views: imageView, updatedLabel)
        addConstraintsWithFormat("V:|-14-[v0(125)]", views: imageView)
        
        addConstraintsWithFormat("V:|-20-[v0(20)][v1][v2][v3]", views: nameLabel, creatorLabel, durationLabel, updatedLabel)
        
        addConstraintsWithFormat("H:[v0(60)]-14-|", views: buyButton)
        addConstraintsWithFormat("V:[v0(32)]-5-|", views: buyButton)
        
        buyButton.addTarget(self, action: #selector(handleBuy), for: .touchUpInside)
    }
    
    func handleBuy(){
        print("Buy Button")
        let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI4MGE2MDgzMTgyZmYyNzY2Y2RmMjc1YWFmYTM0MmZhMTk0YTIyMmM0ZTFlMWEwZTFiMzgzMTc2NGRjNDdmOWJifGNyZWF0ZWRfYXQ9MjAxNy0wMy0xNFQyMTozNzoxNi4yNzM1ODkzNDUrMDAwMFx1MDAyNm1lcmNoYW50X2lkPXc3N3FwZnprN3o4ODZ6ZHBcdTAwMjZwdWJsaWNfa2V5PTV6YnoybmZzMnM5dHlmd3YiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvdzc3cXBmems3ejg4NnpkcC9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzL3c3N3FwZnprN3o4ODZ6ZHAvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tL3c3N3FwZnprN3o4ODZ6ZHAifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiZmxvbmVseXBsYW5ldCIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImZsb25lbHlwbGFuZXQiLCJjdXJyZW5jeUlzb0NvZGUiOiJVU0QifSwiY29pbmJhc2VFbmFibGVkIjpmYWxzZSwibWVyY2hhbnRJZCI6Inc3N3FwZnprN3o4ODZ6ZHAiLCJ2ZW5tbyI6Im9mZiJ9"
        showDropIn(clientTokenOrTokenizationKey: clientToken)
        
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
                print(result.paymentMethod?.nonce ?? "")
                print("Succes")
                ApiService.sharedInstance.checkout(nonce: (result.paymentMethod?.nonce)!)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        if let parent = parent {
            parent.present(dropIn!, animated: true, completion: nil)
        }
        
        
    }
}
