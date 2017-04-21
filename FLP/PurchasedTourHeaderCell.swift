//
//  PurchasedTourHeaderCell.swift
//  FLP
//
//  Created by Bob De Kort on 3/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class PurchasedTourHeaderCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Awesome tour"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "San Francisco"
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "by Test"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(white: 0.3, alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviewButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Leave a review ", for: .normal)
        btn.setTitleColor(UIColor.projectColor(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.projectColor().cgColor
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    var parent: PurchasedTourDetailController? {
        didSet{
            if let tour = parent?.tour {
                titleLabel.text = tour.title
                cityLabel.text = tour.city
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupViews()
    }
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(cityLabel)
        addSubview(reviewButton)
        addSubview(subtitleLabel)
        addSubview(bottomBorder)
        
        addConstraintsWithFormat("V:|-10-[v0][v1]", views: titleLabel, cityLabel)
        addConstraintsWithFormat("H:|-5-[v0]", views: titleLabel)
        addConstraintsWithFormat("H:|-5-[v0]", views: cityLabel)
        
        addConstraints([
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomBorder.topAnchor, constant: -5),
            subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            
            reviewButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            reviewButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),])
        
        addConstraintsWithFormat("H:|[v0]|", views: bottomBorder)
        addConstraintsWithFormat("V:[v0(1)]|", views: bottomBorder)
        
        reviewButton.addTarget(self, action: #selector(handelLeaveReview), for: .touchUpInside)
    }

    func handelLeaveReview(){
        if let parent = parent {
            parent.leaveReview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
