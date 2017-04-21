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
                // subtitleLabel.text = "\(review.user.firstName)\(review.user.lastName)"
                subtitleLabel.text = "Bob De Kort"
                contentLabel.text = review.content
            }
        }
    }
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let subtitleLabel: UILabel = { // Name and date
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = .lightGray
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let contentLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        addSubview(titleLabel)
//        addSubview(subtitleLabel)
        addSubview(contentLabel)
        addSubview(dividerLine)
        
        addConstraintsWithFormat("H:|[v0]-5-|", views: titleLabel)
//        addConstraintsWithFormat("H:|-5-[v0]-5-|", views: subtitleLabel)
        addConstraintsWithFormat("H:|-1-[v0]-5-|", views: contentLabel)
        addConstraintsWithFormat("H:|[v0]|", views: dividerLine)
        addConstraintsWithFormat("V:|-5-[v0]-(-5)-[v1]-5-[v2(1)]|", views: titleLabel, contentLabel, dividerLine)
    }
}
