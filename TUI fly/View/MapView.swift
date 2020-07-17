//
//  MapView.swift
//  TUI fly
//
//  Created by Aaron Taylor on 11/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @Binding var mapPins: [MapPin]?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        guard let annotations = mapPins else { return }
        uiView.showAnnotations(annotations, animated: true)
    }
}
