//
//  TourCell.swift
//  FLP
//
//  Created by Bob De Kort on 2/16/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class TourCell: UICollectionViewCell {
    
    var tour: Tour? {
        didSet{
            if let tour = tour {
                titleLabel.text = tour.title
//                imageView.image = UIImage(named: tour.imageName)
                imageView.downloadedFrom(link: "\(tour.imageName)-mobile.")
                if let updated = tour.updated {
                    subTitleLabel.text = "~\(tour.duration) hours - updated \(updated)"
                } else {
                    subTitleLabel.text = "~\(tour.duration) hours"
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingView: RatingView = {
        let rv = RatingView()
        rv.translatesAutoresizingMaskIntoConstraints = false
        return rv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 7
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupViews(){
        setBackgroundImage()
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(ratingView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-7-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-7-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": subTitleLabel]))
        
        addConstraintsWithFormat("V:|-\((((self.backgroundView?.bounds.height)!/2) + 5))-[v0][v1]-5-|", views: titleLabel, subTitleLabel)
        
        addConstraint(NSLayoutConstraint(item: ratingView, attribute: .bottom, relatedBy: .equal, toItem: self.backgroundView, attribute: .bottom, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: ratingView, attribute: .right, relatedBy: .equal, toItem: self.backgroundView, attribute: .right, multiplier: 1, constant: -45))
    }
    
    func setBackgroundImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.65
        blurEffectView.frame = CGRect(x: 0, y: self.bounds.midY + 10, width: self.bounds.width, height: self.bounds.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundView = imageView
        self.backgroundView?.addSubview(blurEffectView)
    }
}

class Rating: UIView {
    
}
