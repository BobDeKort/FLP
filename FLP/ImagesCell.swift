//
//  ImagesCell.swift
//  FLP
//
//  Created by Bob De Kort on 4/18/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit
import ImageSlideshow
import AlamofireImage

class ImageScrollerCollectionViewCell: BaseCell {
    
    let imageShow: ImageSlideshow = {
        let view = ImageSlideshow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imagesUrls: [String]? {
        didSet{
            if let urls = imagesUrls {
                let inputs = makeImageShowInputs(urls: urls)
                imageShow.setImageInputs(inputs)
            }
        }
    }
    
    override func setupViews() {
        
        self.backgroundColor = .black
        addSubview(imageShow)
        
        imageShow.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageShow.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageShow.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageShow.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    func makeImageShowInputs(urls: [String]) -> [InputSource]{
            var inputs: [InputSource] = []
            for i in urls {
                let input = AlamofireSource(urlString: i)
                if let input = input {
                    inputs.append(input)
                }
            }
            return inputs
    }
}
