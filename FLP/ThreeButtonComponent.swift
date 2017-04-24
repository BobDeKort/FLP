//
//  ThreeButtonComponent.swift
//  FLP
//
//  Created by Bob De Kort on 3/30/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class ThreeButtonComponent: UIView {
    
    let topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let contactButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Contact", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(.blue, for: .normal)
        // btn.setImage(UIImage(named: "contact"), for: .normal)
        return btn
    }()
    
    let navigationButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Navigation", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(.blue, for: .normal)
        // btn.setImage(UIImage(named: "navigation"), for: .normal)
        return btn
    }()
    
    let moreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("More", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(.blue, for: .normal)
        //btn.setImage(UIImage(named: "more"), for: .normal)
        return btn
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .center
        
        
        return sv
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeStackview()
        setupViews()
    }
    
    func setupViews(){
        addSubview(topLine)
        addSubview(stackView)
        addSubview(bottomLine)
        
        addConstraintsWithFormat("H:|-5-[v0]-5-|", views: topLine)
        addConstraintsWithFormat("H:|-5-[v0]-5-|", views: bottomLine)
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: stackView)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX , relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraintsWithFormat("V:|[v0(0.5)][v1][v2(0.5)]|", views: topLine, stackView, bottomLine)
        
    }
    
    func makeStackview(){
        stackView.addArrangedSubview(contactButton)
        stackView.addArrangedSubview(navigationButton)
        stackView.addArrangedSubview(moreButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
