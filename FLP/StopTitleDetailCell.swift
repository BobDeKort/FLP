//
//  StopTitleDetailCell.swift
//  FLP
//
//  Created by Bob De Kort on 4/20/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class StopTitleCell: BaseCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        addSubview(titleLabel)
//        addSubview(separatorView)
        
        addConstraints([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
            
//            separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
//            separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
//            separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            separatorView.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
}
