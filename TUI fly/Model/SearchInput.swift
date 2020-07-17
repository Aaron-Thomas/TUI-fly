//
//  TripPlanner.swift
//  TUI fly
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import Foundation

class SearchInput: ObservableObject {
    
    @Published var selectedDirection = Direction.from
    @Published var fromDestination = ""
    @Published var toDestination = ""
    @Published var showSearchView = false
    @Published var showResultsView = false
}

enum Direction {
    case from, to
}
