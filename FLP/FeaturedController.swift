//
//  FeaturedControllerCollectionViewController.swift
//  FLP
//
//  Created by Bob De Kort on 2/16/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit


class FeaturedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let categoryCellId = "categoryCell"
    fileprivate let bannerId = "headerId"
    
    var featuredTours: [Tour]?
    var tourCategories: [TourCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tourCategories = TourCategory.sampleData()
        
        // Setup
        self.title = "Featured"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
        collectionView?.register(FeaturedBanner.self, forCellWithReuseIdentifier: bannerId)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = tourCategories?.count {
            return count + 1
        }
        return 0

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerId, for: indexPath) as! FeaturedBanner
            cell.featuredController = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryCell
        // Configure the cell
        cell.tourCategory = tourCategories?[indexPath.item-1]
        cell.featuredController = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 200)
        }
        return CGSize(width: view.frame.width, height: 160)
    }
    
    //MARK:
    
    func showTourDetailForTour(_ tour: Tour) {
        let layout = UICollectionViewFlowLayout()
        let tourDetailController = TourDetailController(collectionViewLayout: layout)
        tourDetailController.tour = tour
        navigationController?.pushViewController(tourDetailController, animated: true)
    }
}
