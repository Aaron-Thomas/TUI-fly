//
//  SearchViewModel.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import Foundation

class SearchViewModel: ObservableObject {

    @Published var searchText = ""
    @Published var connections: [Connection]
    var filteredDestinations = [String]()
    var selectedFromDestination = ""
    var selectedToDestination = ""

    init(connections: [Connection]) {
        self.connections = connections
    }
    
    func filteredDestinations(searchInput: SearchInput) -> [String] {
        filteredDestinations.removeAll()
        selectedFromDestination = searchInput.fromDestination
        selectedToDestination = searchInput.toDestination
        
        for connection in connections {
            let destination = getDestination(for: connection, direction: searchInput.selectedDirection)
            filterPossibleConnections(for: searchInput.selectedDirection, destination: destination, for: connection)
            filterSearchText(for: destination)
        }
        
        return filteredDestinations
    }
    
    func filterPossibleConnections(for direction: Direction, destination: String, for connection: Connection) {
        if direction == .from {
            if !selectedToDestination.isEmpty {
                if connection.to.contains(selectedToDestination) {
                    filteredDestinations.append(connection.from)
                }
            } else {
                append(destination: destination)
            }
        } else {
            if !selectedFromDestination.isEmpty {
                if connection.from.contains(selectedFromDestination) {
                    filteredDestinations.append(connection.to)
                }
            } else {
                append(destination: destination)
            }
        }
    }
    
    func append(destination: String) {
        if !filteredDestinations.contains(destination) {
            filteredDestinations.append(destination)
        }
    }
    
    func filterSearchText(for destination: String) {
        if !searchText.isEmpty {
            if !destination.lowercased().contains(searchText.lowercased()) {
                filteredDestinations.removeAll(where: { $0 == destination })
            }
        }
    }
    
    func getDestination(for connection: Connection, direction: Direction) -> String {
        if direction == .from {
            return connection.from
        } else {
            return connection.to
        }
    }
}
