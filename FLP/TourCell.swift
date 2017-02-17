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
                titleLabel.text = tour.name
                imageView.image = UIImage(named: tour.imageName)
                subTitleLabel.text = "~\(tour.duration) - updated \(tour.updated)"
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
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let starRating: CosmosView = {
        let view = CosmosView()
        view.totalStars = 5
        view.filledColor = .yellow
        view.emptyColor = .clear
        view.starSize = 20
        view.rating = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        setBackgroundImage()
        addSubview(starRating)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-7-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-7-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": subTitleLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(self.bounds.width - starRating.bounds.width)-[v0]-7-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": starRating]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v0]-\((((self.backgroundView?.bounds.height)!/2) - starRating.bounds.height)+5)-[v1][v2]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": starRating, "v1": titleLabel, "v2": subTitleLabel]))
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
