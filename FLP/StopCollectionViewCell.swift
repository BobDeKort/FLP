//
//  StopCollectionViewCell.swift
//  FLP
//
//  Created by Bob De Kort on 3/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class StopCollectionViewCell: UICollectionViewCell {
    
    var stop: Stop? {
        didSet{
            if let stop = stop {
                if let urls = stop.imageUrls {
                    if let url = URL(string: urls[0]) {
                        imageView.downloadedFrom(url: url, contentMode: .scaleAspectFill)
                    }
                }
                titleLabel.text = stop.title
                subtitleLabel.text = getAddress()
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .center
        iv.backgroundColor = UIColor.projectBackgroundColor()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupViews()
        addBorder()
    }
    
    func setupViews(){
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        addConstraintsWithFormat("V:|[v0(150)]-5-[v1][v2]-5-|", views: imageView,titleLabel, subtitleLabel)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("H:|-5-[v0]-5-|", views: titleLabel)
        addConstraintsWithFormat("H:|-5-[v0]-5-|", views: subtitleLabel)
    }
    
    func addBorder(){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 2
    }
    
    func getAddress() -> String{
        if let stop = stop {
            let wordArray = stop.address.characters.split{$0 == ","}.map(String.init)
            var address = ""
            for i in 0...wordArray.count-3 {
                if i == wordArray.count-3 {
                    address.append("\(wordArray[i])")
                } else {
                    address.append("\(wordArray[i]),")
                }
            }
            return address
        }
        return ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
