//
//  TourDetailHeader.swift
//  FLP
//
//  Created by Bob De Kort on 2/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class TourDetailHeader: BaseCell {
    
    var tour: Tour?{
        didSet{
            if let tour = tour {
                nameLabel.text = tour.name
                if tour.price == 0 {
                    buyButton.setTitle("Free", for: .normal)
                } else {
                    buyButton.setTitle("$\(String(tour.price))", for: .normal)
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
    }
}
