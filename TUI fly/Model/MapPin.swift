//
//  MapPin.swift
//  TUI fly
//
//  Created by Aaron Taylor on 11/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
