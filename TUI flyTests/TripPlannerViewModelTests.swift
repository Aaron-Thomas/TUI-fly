//
//  TripPlannerViewModelTests.swift
//  TUI flyTests
//
//  Created by Aaron Taylor on 09/07/2020.
//  Copyright © 2020 TUI. All rights reserved.
//

import XCTest
@testable import TUI_fly

class TripPlannerViewModelTests: XCTestCase {
    
    fileprivate var viewModel: TripPlannerViewModel!

    override func setUpWithError() throws {
        viewModel = TripPlannerViewModel()
        XCTAssertNotNil(viewModel)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        XCTAssertNil(viewModel)
    }

    func testSearchBtnEnabled() {
        let searchInput = SearchInput()
        searchInput.fromDestination = "London"
        searchInput.toDestination = "Tokyo"
        let buttonEnabled = viewModel.isSearchDisabled(searchInput: searchInput)
        XCTAssertFalse(buttonEnabled)
    }
    
    func testSearchBtnDisabledTo() {
        let searchInput = SearchInput()
        searchInput.fromDestination = "London"
        searchInput.toDestination = ""
        
        let buttonEnabled = viewModel.isSearchDisabled(searchInput: searchInput)
        XCTAssertTrue(buttonEnabled)
    }
    
    func testSearchBtnDisabledFrom() {
        let searchInput = SearchInput()
        searchInput.fromDestination = ""
        searchInput.toDestination = "Tokyo"
        
        let buttonEnabled = viewModel.isSearchDisabled(searchInput: searchInput)
        XCTAssertTrue(buttonEnabled)
    }
}
