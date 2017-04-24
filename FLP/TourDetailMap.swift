//
//  TourDetailMap.swift
//  FLP
//
//  Created by Bob De Kort on 2/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class TourDetailMap: BaseCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Map"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "map")
        iv.layer.cornerRadius = 16
        return iv
    }()
 
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(dividerLineView)
        addSubview(imageView)
        
        addConstraintsWithFormat("H:|-14-[v0]-8-|", views: titleLabel)
        addConstraintsWithFormat("H:|-14-[v0]-8-|", views: dividerLineView)
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: imageView)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]-8-[v2]-5-|", views: titleLabel, dividerLineView, imageView)
    }
}
