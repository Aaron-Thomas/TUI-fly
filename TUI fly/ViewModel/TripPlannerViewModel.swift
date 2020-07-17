//
//  TripPlannerViewModel.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import Foundation

class TripPlannerViewModel: ObservableObject, Networking {

    @Published var connections = [Connection]()
    @Published var errorMessage = ""
    @Published var showError = false
    
    init() {
        getConnections()
    }
    
    func getConnections() {
        let url = Endpoints.getConnections
        networkRequest(returnType: Connections.self, urlString: url) { result in
            switch result {
            case .success(let allConnections):
                DispatchQueue.main.async {
                    self.connections = allConnections.connections
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }
        }
    }
    
    func isSearchDisabled(searchInput: SearchInput) -> Bool {
        searchInput.fromDestination.isEmpty || searchInput.toDestination.isEmpty ? true : false
    }
}
