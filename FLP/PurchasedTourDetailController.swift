//
//  PurchasedTourDetailController.swift
//  FLP
//
//  Created by Bob De Kort on 3/26/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class PurchasedTourDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var tour: Tour?{
        didSet{
            if let tour = tour {
                if let stops = tour.stops {
                    ApiService.sharedInstance.getStops(tourId: tour.id, stopIds: stops, completionHandler: { (stops) in
                        self.stops = stops
                    })
                }
            }
        }
    }
    
    var stops: [Stop]? {
        didSet{
            collectionView?.reloadData()
        }
    }
    
    fileprivate let reuseIdentifier = "CellId"
    fileprivate let headerId = "HeaderId"
    fileprivate let stopId = "StopId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = .white
        setupNavBarButtons()
        
        // Register cell classes
        self.collectionView?.register(PurchasedTourHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        self.collectionView?.register(StopCollectionViewCell.self, forCellWithReuseIdentifier: stopId)

    }

    func setupNavBarButtons(){
        let mapButton = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(handelMapButton))
        
        navigationItem.rightBarButtonItem = mapButton
        
    }
    
    func handelMapButton(){
        if UIApplication.shared.canOpenURL( URL(string: "comgooglemaps-x-callback://")!) {
            let url = makeGoogleMapsUrl()
            if let url = url {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:]) { (result) in
                        
                    }
                }
            } else {
                print("Map url is not a url")
            }
        } else {
            showMapView()
        }
    }
    
    func makeGoogleMapsUrl() -> URL? {
        if let stops = stops {
            var baseurl = "https://www.google.com/maps/dir/"
            for i in stops {
                let address = "\(i.address)/"
                let encodedString = address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
                baseurl.append(encodedString!)
            }
            if let url = URL(string: baseurl) {
                return url
            } else {
                return nil
            }
        }
        return nil
    }
    
    func showMapView(){
        let vc = MapViewController()
        vc.tour = self.tour
        vc.stops = self.stops
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func leaveReview(){
        let vc = LeaveReviewViewController()
        vc.tourId = tour?.id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let tour = tour {
            if let stops = tour.stops {
                return stops.count
            } else {
                // TODO: Handel no stops in tour
            }
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stopId, for: indexPath) as! StopCollectionViewCell
        if let stops = stops {
            cell.stop = stops[indexPath.item]
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 26, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PurchasedTourHeaderCell
        
        header.parent = self
        if let tour = tour {
            let dateFormatter = DateFormatter()
            header.subtitleLabel.text = "Duration: \(tour.duration) hours - Updated: \(dateFormatter.timeSince(from: tour.updated as NSDate))"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 0, bottom: 10.0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let stops = stops {
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            
            let vc = StopDetailViewController(collectionViewLayout: layout)
            vc.stop = stops[indexPath.item]
            vc.hidesBottomBarWhenPushed = true
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
