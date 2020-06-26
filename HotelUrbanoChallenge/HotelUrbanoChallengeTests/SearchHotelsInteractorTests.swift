//
//  SearchHotelsInteractorTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class SearchHotelsInteractorTests: XCTestCase {
    
    private var hotelSearchServiceMock: HotelSearchServiceMock!
    private var interactor: SearchHotelsInteractor!
    
    override func setUpWithError() throws {
        self.hotelSearchServiceMock = HotelSearchServiceMock()
        self.interactor = SearchHotelsInteractor(service: self.hotelSearchServiceMock)
    }
    
    override func tearDownWithError() throws {
        self.hotelSearchServiceMock = nil
        self.interactor = nil
    }
    
    func testInitialValues() throws {
        XCTAssertEqual(self.hotelSearchServiceMock.callCount, 0)
        XCTAssertEqual(self.hotelSearchServiceMock.lastLocation, "")
    }
    
    func testServiceCall() throws {
        self.interactor.search(in: "Location Value") { _ in }
        
        XCTAssertEqual(self.hotelSearchServiceMock.callCount, 1)
        XCTAssertEqual(self.hotelSearchServiceMock.lastLocation, "Location Value")
    }
    
    func testServiceFindHotels() throws {
        let hotelListMock = ["First Hotel",
                             "Second Hotel",
                             "Third Hotel"]
        self.hotelSearchServiceMock.hotels = hotelListMock
        
        let expectation = self.expectation(description: "Service find hotels")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(let hotels):
                XCTAssertEqual(hotels, hotelListMock)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceCouldNotFindHotels() throws {
        self.hotelSearchServiceMock.hotels = []
        
        let expectation = self.expectation(description: "Service find hotels")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(let hotels):
                XCTAssertEqual(hotels, [])
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceError() throws {
        self.hotelSearchServiceMock.error = .requestTimeout
        
        let expectation = self.expectation(description: "Service find hotels")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .requestTimeout)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
