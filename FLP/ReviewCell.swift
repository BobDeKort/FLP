//
//  ReviewCell.swift
//  FLP
//
//  Created by Bob De Kort on 3/30/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class ReviewCell: BaseCell {
    
    var review: Review?{
        didSet{
            if let review = review {
                titleLabel.text = review.title
                subtitleLabel.text = review.username
                contentLabel.text = review.content
            }
        }
    }
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let contentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(contentLabel)
        addSubview(dividerLine)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        contentLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        dividerLine.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 5).isActive = true
        dividerLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dividerLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
//        addConstraintsWithFormat("H:|[v0]-5-|", views: titleLabel)
//        addConstraintsWithFormat("H:|-5-[v0]-5-|", views: subtitleLabel)
//        addConstraintsWithFormat("H:|-1-[v0]-5-|", views: contentLabel)
//        addConstraintsWithFormat("H:|[v0]|", views: dividerLine)
//        addConstraintsWithFormat("V:|-5-[v0]-(-5)-[v1]-5-[v2(1)]|", views: titleLabel, contentLabel, dividerLine)
    }
}
