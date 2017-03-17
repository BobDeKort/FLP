//
//  MyTourCollectionViewCell.swift
//  FLP
//
//  Created by Bob De Kort on 3/9/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class MyTourCollectionViewCell: UICollectionViewCell {
    
    var tour: Tour? {
        didSet{
            if let tour = tour {
                titleLabel.text = tour.title
                imageView.image = UIImage(named: tour.imageName)
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
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "image1")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    func setupViews(){
        setBackgroundImage()
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-7-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-7-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": subTitleLabel]))
        
        addConstraintsWithFormat("V:|-\((((self.backgroundView?.bounds.height)!/2) + 15))-[v0][v1]-5-|", views: titleLabel, subTitleLabel)
    }
    
    func setBackgroundImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.65
        blurEffectView.frame = CGRect(x: 0, y: self.bounds.midY + 20 , width: self.bounds.width, height: self.bounds.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundView = imageView
        self.backgroundView?.addSubview(blurEffectView)
    }
}
