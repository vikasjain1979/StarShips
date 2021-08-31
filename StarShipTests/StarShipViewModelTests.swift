//
//  StarShipViewModelTests.swift
//  StarShipTests
//
//  Created by Jain, Vikas on 31/8/21.
//  Copyright © 2021 Jain, Vikas. All rights reserved.
//

import XCTest
@testable import StarShip

class StarShipViewModelTests: XCTestCase {

    var mockService: MockService<StarShips>!
    var viewModel: StarShipViewModel!
    var successExpectation: XCTestExpectation!
    var failureExpectation: XCTestExpectation!
    var starShipsModel: StarShips!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Mock Service Request Coordinator
        self.mockService = MockService()
        self.mockService.mockResponse = MockResponse.makeResponse()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetStarshipsInfo() {
        self.successExpectation = XCTestExpectation(description: "The API response is recieved")
        viewModel = StarShipViewModel(serviceCoordinator: mockService, delegate: self)
        viewModel.getStarShipsInfo()
        self.wait(for: [successExpectation], timeout: 1.0)
    }
    
    func testGetStarshipsInfoError() {
        self.mockService.isForcedError = true
        self.failureExpectation = XCTestExpectation(description: "The API response should fail")
        viewModel = StarShipViewModel(serviceCoordinator: mockService, delegate: self)
        viewModel.getStarShipsInfo()
        self.wait(for: [failureExpectation], timeout: 1.0)
    }

    func testManageFavorites() {
        // Get the model
        self.successExpectation = XCTestExpectation(description: "The API response is recieved")
        viewModel = StarShipViewModel(serviceCoordinator: mockService, delegate: self)
        viewModel.getStarShipsInfo()
        self.wait(for: [successExpectation], timeout: 1.0)
        
        //Add a model as favorite
        XCTAssertTrue(self.viewModel.favoriteStarShips.count == 0)
        self.viewModel.manageFavorite(starShip: self.starShipsModel.allShips[0])
        XCTAssertTrue(self.viewModel.favoriteStarShips.count == 1)
        XCTAssertTrue(self.viewModel.favoriteStarShips[0].name == self.starShipsModel.allShips[0].name)
        
        //Removing a favorite
        self.viewModel.manageFavorite(starShip: self.starShipsModel.allShips[0])
        XCTAssertTrue(self.viewModel.favoriteStarShips.count == 0)
    }
    
    func testIsFavorite() {
        // Get the model
        self.successExpectation = XCTestExpectation(description: "The API response is recieved")
        viewModel = StarShipViewModel(serviceCoordinator: mockService, delegate: self)
        viewModel.getStarShipsInfo()
        self.wait(for: [successExpectation], timeout: 1.0)
     
        let model = self.starShipsModel.allShips.first!
        self.viewModel.manageFavorite(starShip: model)
        XCTAssertTrue(self.viewModel.isFavorite(starShip: model))
        
        self.viewModel.manageFavorite(starShip: model)
        XCTAssertFalse(self.viewModel.isFavorite(starShip: model))
    }
}


extension StarShipViewModelTests: StarShipViewModelDelegate {
    func starShipInfoDelegate(_ value: StarShips) {
        if (value.count > 0 ) {
            self.starShipsModel = value
            self.successExpectation.fulfill()
        } else {
            XCTFail()
        }
    }
    
    func handleError(_ error: StarShipError) {
        if error == .serviceUnavailable {
            self.failureExpectation.fulfill()
        } else {
            XCTFail()
        }
    }
    
    
}
