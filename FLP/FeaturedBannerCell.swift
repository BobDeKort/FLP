//
//  FeaturedBannerCell.swift
//  FLP
//
//  Created by Bob De Kort on 2/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class FeaturedBannerCell: BaseCell {
    var tour: Tour? {
        didSet{
            if let tour = tour {
                titleLabel.text = tour.title
                imageView.image = UIImage(named: tour.imageName)
                if let updated = tour.updated {
                    subTitleLabel.text = "~\(tour.duration) - updated \(updated)"
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
        iv.contentMode = .scaleToFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override func setupViews(){
        setBackgroundImage()
        
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: titleLabel)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: subTitleLabel)
        addConstraintsWithFormat("V:|-\(self.bounds.maxY - self.bounds.height*(1/3))-[v0]-2-[v1]", views: titleLabel, subTitleLabel)
    }
    
    func setBackgroundImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.40
        blurEffectView.frame = CGRect(x: 0, y: (self.bounds.maxY - self.bounds.height*(1/3)), width: self.bounds.width, height: self.bounds.height*(2/3))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.backgroundView = imageView
        self.backgroundView?.addSubview(blurEffectView)
    }
}
