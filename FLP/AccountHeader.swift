//
//  AccountHeader.swift
//  FLP
//
//  Created by Bob De Kort on 3/7/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class AccountHeader: BaseCell {
    
    var accountViewController: AccountViewController?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 16
        iv.image = UIImage(named: "image1")
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Purchased", "My tours"])
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bob De Kort"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    func handelSegementedControlPressed(_ sender: UISegmentedControl){
        if let parent = accountViewController {
//            parent.currentSegmentedIndex = sender.selectedSegmentIndex
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("V:|-14-[v0(100)]", views: imageView)
        
        addConstraintsWithFormat("V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithFormat("H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithFormat("V:[v0(34)]-8-|", views: segmentedControl)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
        
        addTargets()
    }
    
    func addTargets(){
        segmentedControl.addTarget(self, action: #selector(handelSegementedControlPressed), for: .allEvents)
    }
}
