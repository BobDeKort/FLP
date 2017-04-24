//
//  MapViewController.swift
//  FLP
//
//  Created by Bob De Kort on 4/4/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate  {
    
    var tour: Tour?
    
    var stops: [Stop]?{
        didSet{
            addStopsToMap()
        }
    }

    let mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        map.showsPointsOfInterest = false
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(mapView)
        view.addSubview(backButton)
        
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: mapView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .top, relatedBy: .equal, toItem: mapView, attribute: .top, multiplier: 1, constant: 25))
        view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 5))
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        setOriginPointMap()
    }
    
    func addStopsToMap(){
        if let stops = stops {
            var annotations = [StopMapAnnotation]()
            for stop in stops{
                getCoordinateFromAddress(address: stop.address, completion: { (coordinate) in
                    let annotation = StopMapAnnotation(title: stop.title, coordinate: coordinate)
                    annotations.append(annotation)
                    if annotations.count == stops.count {
                        self.mapView.addAnnotations(annotations)
                    }
                })
            }
        }
    }
    
    func setOriginPointMap(){
        if let tour = tour {
            getCoordinateFromAddress(address: tour.city, completion: { (coordinates) in
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 10000, 10000)
                
                self.mapView.setRegion(region, animated: true)
            })
        }
    }
    
    func getCoordinateFromAddress(address: String, completion: @escaping (CLLocationCoordinate2D) -> Void){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (places, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            
            if let places = places {
                if let location = places[0].location {
                    completion(location.coordinate)
                }
            }
        }
    }
    
    func backButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}
