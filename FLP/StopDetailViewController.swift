//
//  StopDetailViewController.swift
//  FLP
//
//  Created by Bob De Kort on 4/18/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class StopDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let descriptioncellId = "descriptioncellId"
    fileprivate let buttonsCellId = "buttonsCellId"
    fileprivate let imageCellId = "imageCellId"
    fileprivate let titleCellId = "titleCellId"
    fileprivate let reuseIdentifier = "reuseIdentifier"
    
    var stop: Stop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(StopDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptioncellId)
        self.collectionView?.register(StopDetailButtons.self, forCellWithReuseIdentifier: buttonsCellId)
        self.collectionView?.register(ImageScrollerCollectionViewCell.self, forCellWithReuseIdentifier: imageCellId)
        self.collectionView?.register(StopTitleCell.self, forCellWithReuseIdentifier: titleCellId)

        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        // Image Scroller
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath) as! ImageScrollerCollectionViewCell
            cell.imagesUrls = stop?.imageUrls
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellId, for: indexPath) as! StopTitleCell
            cell.titleLabel.text = stop?.title
            return cell
        // Description Cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptioncellId, for: indexPath) as! StopDetailDescriptionCell
            
            cell.textView.attributedText = descriptionAttributedText()
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        
        case 0:
            return CGSize(width: view.frame.width, height: 200)
        case 1:
            return CGSize(width: view.frame.width, height: 30)
        case 2:
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 50)
        default:
            return CGSize(width: view.frame.width, height: 170)
        }
    }
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = stop?.description {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.darkGray]))
        }
        
        return attributedText
    }
}
