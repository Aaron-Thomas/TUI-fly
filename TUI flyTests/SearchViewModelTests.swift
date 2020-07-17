//
//  SearchViewModelTests.swift
//  TUI flyTests
//
//  Created by Aaron Taylor on 11/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import XCTest
@testable import TUI_fly

class SearchViewModelTests: XCTestCase {

    fileprivate var viewModel: SearchViewModel!
    
    override func setUpWithError() throws {
        setConnectionsStub()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        XCTAssertNil(viewModel)
    }

    func testFilterDestinations() throws {
        let searchInput = SearchInput()
        searchInput.fromDestination = "Cape Town"
        searchInput.toDestination = "London"
        searchInput.selectedDirection = .to
        let filteredDestinations = viewModel.filteredDestinations(searchInput: searchInput)
        
        XCTAssertEqual(filteredDestinations.count, 1)
    }
    
    func testFilterDestinationsFail() throws {
        let searchInput = SearchInput()
        searchInput.fromDestination = "Cape Town"
        searchInput.toDestination = "London"
        searchInput.selectedDirection = .from
        let filteredDestinations = viewModel.filteredDestinations(searchInput: searchInput)
        
        XCTAssertNotEqual(filteredDestinations.count, 1)
    }
    
    func testFilterPossibleConnections() {
        guard let londonToTokyoConnection = viewModel.connections.first else {
            XCTFail("Couldn't get first connection from stub")
            return
        }
        let direction = Direction.from
        let destination = "London"
        
        viewModel.filterPossibleConnections(for: direction, destination: destination, for: londonToTokyoConnection)
        XCTAssertEqual(viewModel.filteredDestinations.count, 1)
    }
    
    func testAppendDestination() {
        let destinations = ["London", "Tokyo", "Sydney"]
        let newDestination = "Cape Town"
        
        viewModel.filteredDestinations = destinations
        XCTAssertEqual(viewModel.filteredDestinations.count, 3)
        viewModel.append(destination: newDestination)
        XCTAssertEqual(viewModel.filteredDestinations.count, 4)
    }
    
    func testAppendDuplicateDestinationFail() {
        let destinations = ["London", "Tokyo", "Sydney"]
        let newDestination = "Tokyo"
        
        viewModel.filteredDestinations = destinations
        XCTAssertEqual(viewModel.filteredDestinations.count, 3)
        viewModel.append(destination: newDestination)
        XCTAssertNotEqual(viewModel.filteredDestinations.count, 4)
        XCTAssertEqual(viewModel.filteredDestinations.count, 3)
    }
    
    func testGetDestinationTo() {
        guard let londonToTokyoConnection = viewModel.connections.first else {
            XCTFail("Couldn't get first connection from stub")
            return
        }
        let direction = Direction.from
        let destination = viewModel.getDestination(for: londonToTokyoConnection, direction: direction)
        
        XCTAssertEqual(destination, "London")
    }
    
     func testGetDestinationFrom() {
        guard let londonToTokyoConnection = viewModel.connections.first else {
            XCTFail("Couldn't get first connection from stub")
            return
        }
        let direction = Direction.to
        let destination = viewModel.getDestination(for: londonToTokyoConnection, direction: direction)
        
        XCTAssertEqual(destination, "Tokyo")
    }
}

extension SearchViewModelTests: ConnectionsStub {
    
    func setConnectionsStub() {
        getConnectionsStub { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let allConnections):
                let connections = allConnections.connections
                self.viewModel = SearchViewModel(connections: connections)
            }
        }
        XCTAssertNotNil(viewModel)
    }
}
