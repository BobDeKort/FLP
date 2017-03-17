//
//  FeaturedControllerCollectionViewController.swift
//  FLP
//
//  Created by Bob De Kort on 2/16/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit


class FeaturedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: File Private Variables
    
    fileprivate let categoryCellId = "categoryCell"
    fileprivate let bannerId = "headerId"
    
    // MARK: Variables
    
    var featuredTours: [Tour]?
    var tourCategories: [TourCategory]?{
        didSet{
            collectionView?.reloadData()
        }
    }
    
    // MARK: View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.sharedInstance.getTourCategories { (categories) in
            
            let sortedCategories = categories.sorted( by: { ($0.0.tours?.count)! > ($0.1.tours?.count)! })
            
            self.tourCategories = sortedCategories
        }
        
        // Setup
        self.title = "Discover"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = tourCategories?.count {
            return count
        }
        return 0

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryCell
        // Configure the cell
        cell.tourCategory = tourCategories?[indexPath.item]
        cell.featuredController = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    //MARK: Navigation
    
    func showTourDetailForTour(_ tour: Tour) {
        let layout = UICollectionViewFlowLayout()
        let tourDetailController = TourDetailController(collectionViewLayout: layout)
        tourDetailController.tour = tour
        navigationController?.pushViewController(tourDetailController, animated: true)
    }
}
