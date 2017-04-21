//
//  StopMapAnnotation.swift
//  FLP
//
//  Created by Bob De Kort on 4/12/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class StopMapAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
