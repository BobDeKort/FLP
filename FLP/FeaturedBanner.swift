//
//  FeaturedBanner.swift
//  FLP
//
//  Created by Bob De Kort on 2/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class FeaturedBanner: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate let tourCellId = "tourCellId"
    
    var featuredController: FeaturedController?
    var featuredTours: [Tour]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let toursCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .clear
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
    
    func setupViews(){
        
        
        populateData()
        
        
        addSubview(toursCollectionView)
        
        toursCollectionView.register(FeaturedBannerCell.self, forCellWithReuseIdentifier: tourCellId)
        
        toursCollectionView.dataSource = self
        toursCollectionView.delegate = self
        
        addConstraintsWithFormat("H:|[v0]|", views: toursCollectionView)
        addConstraintsWithFormat("V:|[v0]|", views: toursCollectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = featuredTours?.count{
            return count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tourCellId, for: indexPath) as! FeaturedBannerCell
        
        cell.tour = featuredTours?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: (self.bounds.width/16)*9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tour = featuredTours?[indexPath.item] {
            featuredController?.showTourDetailForTour(tour)
        } else {
            print("error: no tour")
        }
    }
    
    func populateData(){
        let tour = Tour(id: 1, name: "Best Tour Ever", category: "Food", description: "Offices parties lasting outward nothing age few resolve. Impression to discretion understood to we interested he excellence. Him remarkably use projection collecting. Going about eat forty world has round miles. Attention affection at my preferred offending shameless me if agreeable. Life lain held calm and true neat she. Much feet each so went no from. Truth began maids linen an mr to after. Offices parties lasting outward nothing age few resolve. Impression to discretion understood to we interested he excellence. Him remarkably use projection collecting. Going about eat forty world has round miles. Attention affection at my preferred offending shameless me if agreeable. Life lain held calm and true neat she. Much feet each so went no from. Truth began maids linen an mr to after.", imageName: "image1", price: 1.99, updated: "3 days ago", duration: "3hr")
        
        let tour2 = Tour(id: 2, name: "worst Tour", category: "Fun", description: "Can curiosity may end shameless explained. True high on said mr on come. An do mr design at little myself wholly entire though. Attended of on stronger or mr pleasure. Rich four like real yet west get. Felicity in dwelling to drawings. His pleasure new steepest for reserved formerly disposed jennings. ", imageName: "image2", price: 0.99, updated: "3 days ago", duration: "3hr")
        
        self.featuredTours = [tour, tour2]
    }
}
