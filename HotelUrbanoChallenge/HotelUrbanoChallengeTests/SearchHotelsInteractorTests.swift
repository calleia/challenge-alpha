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
    
    func testServiceRequest() throws {
        self.interactor.search(in: "Location Value") { _ in }
        
        XCTAssertEqual(self.hotelSearchServiceMock.callCount, 1)
        XCTAssertEqual(self.hotelSearchServiceMock.lastLocation, "Location Value")
    }
    
    func testServiceFindHotels() throws {
        let hotel = Hotel(id: "Hotel ID",
                          name: "Hotel Name",
                          image: "Hotel Image",
                          stars: 5)
        self.hotelSearchServiceMock.response = HotelServiceResponse(results: [hotel])
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(let hotels):
                XCTAssertEqual(hotels, [hotel])
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceCouldNotFindHotels() throws {
        self.hotelSearchServiceMock.response = HotelServiceResponse(results: [])
        
        let expectation = self.expectation(description: "Service request")
        
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
    
    func testServiceResponseParseError() throws {
        self.hotelSearchServiceMock.error = .couldNotParseResponse
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .invalidServiceResponse)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceConnectionError() throws {
        self.hotelSearchServiceMock.error = .connection("Falha na conexão")
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .connection("Falha na conexão"))
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceInternalError() throws {
        self.hotelSearchServiceMock.error = .server(500)
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .service(500))
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNoServiceResponse() throws {
        self.hotelSearchServiceMock.error = .noResponse
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .invalidServiceResponse)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmptyServiceResponse() throws {
        self.hotelSearchServiceMock.error = .emptyResponse
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .invalidServiceResponse)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchForEmptyLocation() throws {
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "") { result in
            switch result {
            case .success(let hotels):
                XCTAssertEqual(hotels, [])
                XCTAssertEqual(self.hotelSearchServiceMock.callCount, 0)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
