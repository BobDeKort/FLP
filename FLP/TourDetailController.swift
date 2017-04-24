//
//  TourDetailController.swift
//  FLP
//
//  Created by Bob De Kort on 2/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class TourDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Fileprivate Variables
    
    fileprivate let reuseIdentifier = "Cell"
    fileprivate let headerId = "headerId"
    fileprivate let descriptionId = "descriptionId"
    fileprivate let mapId = "mapId"
    fileprivate let reviewId = "reviewId"
    
    // MARK: Variables
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return ai
    }()
    
    var tour: Tour?
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .white
        // Register cell classes
        collectionView?.register(TourDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView?.register(TourDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionId)
        collectionView?.register(TourDetailMap.self, forCellWithReuseIdentifier: mapId)
        collectionView?.register(TourDetailReviews.self, forCellWithReuseIdentifier: reviewId)

        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        setupActivityMonitor()
    }
    
    func setupActivityMonitor(){
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tour?.reviews != nil {
            if tour?.reviews?.count == 0 {
                return 1
            } else {
                return 2
            }
        } else {
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // With map
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! TourDetailDescriptionCell
            if let tour = tour {
                let description = stringFromHtml(string: tour.description)
                
                cell.textView.attributedText = description
                cell.textView.font = UIFont.systemFont(ofSize: 15)
            }
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewId, for: indexPath) as! TourDetailReviews
            if let tour = tour {
                cell.tourId = tour.id
                cell.reviewsIds = tour.reviews
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! TourDetailHeader
        header.tour = tour
        header.parent = self
        return header
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        // description cell
        case 0:
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 50)
        // review cell
        case 1:
            return CGSize(width: view.frame.width, height: 260)
        default:
            return CGSize(width: view.frame.width, height: 170)
        }
    }
    
    // MARK: Description Setup
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = tour?.description {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray]))
        }
        
        return attributedText
    }
    
    private func getHtmlLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = stringFromHtml(string: text)
        return label
    }
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
            return nil
        }
        return nil
    }
}
