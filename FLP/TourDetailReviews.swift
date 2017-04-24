//
//  TourDetailReviews.swift
//  FLP
//
//  Created by Bob De Kort on 2/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class TourDetailReviews: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var reviews: [Review]? {
        didSet {
            reviewsCollectionView.reloadData()
        }
    }
    
    var reviewsIds: [String]? {
        didSet {
            if let ids = reviewsIds {
                getReviews(ids: ids)
            }
        }
    }
    
    var tourId: String?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
        return label
    }()
    
    let reviewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .clear
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.showsVerticalScrollIndicator = false
        return collectionview
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let reviewCellId = "treviewCellId"
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(nameLabel)
        addSubview(reviewsCollectionView)
        addSubview(dividerLineView)
        
        reviewsCollectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
        
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.delegate = self
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": reviewsCollectionView]))
        
        addConstraintsWithFormat("V:|[v0][v1(1)][v2]|", views: nameLabel, dividerLineView, reviewsCollectionView)
        
    }
    
    func getReviews(ids: [String]){
        if let tourId = tourId {
            ApiService.sharedInstance.getReviews(tourId: tourId, reviewIds: ids, completionHandler: { (reviews) in
                self.reviews = reviews
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = reviews?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewCell
        if let reviews = reviews {
            cell.review = reviews[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dummySize = CGSize(width: frame.width - 8 - 8, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descriptionAttributedText(indexPath: indexPath).boundingRect(with: dummySize, options: options, context: nil)
        
        return CGSize(width: frame.width - 50, height: rect.height + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    fileprivate func descriptionAttributedText(indexPath: IndexPath) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = reviews?[indexPath.item].content {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11), NSForegroundColorAttributeName: UIColor.darkGray]))
        }
        return attributedText
    }
}
