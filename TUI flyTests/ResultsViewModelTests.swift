//
//  ResultsViewModelTests.swift
//  TUI flyTests
//
//  Created by Aaron Taylor on 11/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import XCTest
@testable import TUI_fly

class ResultsViewModelTests: XCTestCase {

    fileprivate var viewModel: ResultsViewModel!
    var connections = [Connection]()
    
    override func setUpWithError() throws {
        setConnectionsStub()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        connections.removeAll()
        XCTAssertNil(viewModel)
        XCTAssertEqual(connections.count, 0)
    }

    func testGetSearchResults() throws {
        let searchInput = SearchInput()
        searchInput.fromDestination = "London"
        searchInput.toDestination = "Porto"
        viewModel = ResultsViewModel(searchInput: searchInput, connections: connections)
        
        XCTAssertEqual(viewModel.searchResults.count, 1)
        XCTAssertEqual(viewModel.searchResults.first?.price, 50)
    }
    
    func testGetZeroSearchResults() throws {
        let searchInput = SearchInput()
        searchInput.fromDestination = "London"
        searchInput.toDestination = "Russia"
        viewModel = ResultsViewModel(searchInput: searchInput, connections: connections)
        
        XCTAssertEqual(viewModel.searchResults.count, 0)
    }
    
    func testGetMapPins() {
        guard let londonToTokyoConnection = connections.first else {
            XCTFail("Couldn't get first connection from stub")
            return
        }
        
        let searchInput = SearchInput()
        viewModel = ResultsViewModel(searchInput: searchInput, connections: connections)
        
        let mapPins = viewModel.getMapPins(for: londonToTokyoConnection)

        let londonLat = 51.5285582
        let londonLong = -0.241681
        let tokyoLat = 35.652832
        let tokyoLong = 139.839478
        
        XCTAssertNotNil(mapPins)
        XCTAssertEqual(mapPins?.first?.coordinate.latitude, londonLat)
        XCTAssertEqual(mapPins?.first?.coordinate.longitude, londonLong)
        XCTAssertEqual(mapPins?.last?.coordinate.latitude, tokyoLat)
        XCTAssertEqual(mapPins?.last?.coordinate.longitude, tokyoLong)
    }
    
    func testGetMapPinsCoordinateFail() {
        guard let londonToTokyoConnection = connections.first else {
            XCTFail("Couldn't get first connection from stub")
            return
        }
        
        let searchInput = SearchInput()
        viewModel = ResultsViewModel(searchInput: searchInput, connections: connections)
        
        let mapPins = viewModel.getMapPins(for: londonToTokyoConnection)

        let londonLat = 0.0
        
        XCTAssertNotNil(mapPins)
        XCTAssertNotEqual(mapPins?.first?.coordinate.latitude, londonLat)
    }
}

extension ResultsViewModelTests: ConnectionsStub {
    
    func setConnectionsStub() {
        getConnectionsStub { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let allConnections):
                self.connections = allConnections.connections
            }
        }
        XCTAssertTrue(connections.count > 0)
    }
}
