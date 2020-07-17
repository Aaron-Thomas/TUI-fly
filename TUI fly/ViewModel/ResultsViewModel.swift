//
//  ResultsViewModel.swift
//  TUI fly
//
//  Created by Aaron Taylor on 11/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import Foundation
import MapKit

class ResultsViewModel: ObservableObject {
    
    var searchInput: SearchInput
    var connections = [Connection]()
    @Published var searchResults = [Connection]()

    init(searchInput: SearchInput, connections: [Connection]) {
        self.searchInput = searchInput
        self.connections = connections
        
        getSearchResults()
    }
    
    func getSearchResults() {
        let results = connections.filter {
            $0.from == searchInput.fromDestination && $0.to == searchInput.toDestination
        }
        let sortedResults = results.sorted(by: { $0.price > $1.price })
        searchResults = sortedResults
    }
    
    func getMapPins(for connection: Connection) -> [MapPin]? {
        guard
            let fromCoordinates = connection.coordinates?.from,
            let toCoordinates = connection.coordinates?.to
        else { return nil }
        
        let fromPin = MapPin(title: connection.from, coordinate: CLLocationCoordinate2D(latitude: fromCoordinates.lat, longitude: fromCoordinates.long))
        let toPin = MapPin(title: connection.to, coordinate: CLLocationCoordinate2D(latitude: toCoordinates.lat, longitude: toCoordinates.long))
        
        return [fromPin, toPin]
    }
}
