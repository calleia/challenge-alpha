//
//  HotelSearchServiceTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 28/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class HotelSearchServiceTests: XCTestCase {
    
    private var httpClientMock: HttpClientMock!
    private var service: HotelSearchService!
    
    override func setUpWithError() throws {
        self.httpClientMock = HttpClientMock()
        self.service = HotelSearchService(httpClient: self.httpClientMock)
    }
    
    override func tearDownWithError() throws {
        self.httpClientMock = nil
        self.service = nil
    }
    
    func testInitialValues() throws {
        XCTAssertEqual(self.httpClientMock.callCount, 0)
        XCTAssertEqual(self.httpClientMock.lastUrl, nil)
    }
    
    func testRequest() throws {
        self.service.search(in: "Location Value") { _ in }
        
        XCTAssertEqual(self.httpClientMock.callCount, 1)
    }
    
    func testQueryGeneration() throws {
        self.service.search(in: "Location Value") { _ in }
        XCTAssertEqual(self.httpClientMock.lastUrl?.absoluteString, "https://www.hurb.com/search/api?q=location%20value&filters=is_hotel%7C1&page=1")
        
        self.service.search(in: "  Location Value  ") { _ in }
        XCTAssertEqual(self.httpClientMock.lastUrl?.absoluteString, "https://www.hurb.com/search/api?q=location%20value&filters=is_hotel%7C1&page=1")
        
        self.service.search(in: "Invalid&Characters") { _ in }
        XCTAssertEqual(self.httpClientMock.lastUrl?.absoluteString, "https://www.hurb.com/search/api?q=invalid%26characters&filters=is_hotel%7C1&page=1")
        
        self.service.search(in: "Invalid|Characters") { _ in }
        XCTAssertEqual(self.httpClientMock.lastUrl?.absoluteString, "https://www.hurb.com/search/api?q=invalid%7Ccharacters&filters=is_hotel%7C1&page=1")
        
        self.service.search(in: "Invalid=Characters") { _ in }
        XCTAssertEqual(self.httpClientMock.lastUrl?.absoluteString, "https://www.hurb.com/search/api?q=invalid%3Dcharacters&filters=is_hotel%7C1&page=1")
    }
    
    func testParseResponse() throws {
        guard let jsonPath = Bundle.init(for: type(of: self)).path(forResource: "hotel", ofType: "json") else {
            XCTFail()
            return
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe)
        self.httpClientMock.payload = data
        
        let expectation = self.expectation(description: "Service request")
        
        self.service.search(in: "Location Value") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.results.count, 20)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testParseError() throws {
        self.httpClientMock.payload = Data()
        
        let expectation = self.expectation(description: "Service request")
        
        self.service.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .couldNotParseResponse)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testConnectionError() throws {
        self.httpClientMock.error = .client("Falha na conexão")
        
        let expectation = self.expectation(description: "Service request")
        
        self.service.search(in: "Location Value") { result in
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
    
    func testServerError() throws {
        self.httpClientMock.error = .server(500)
        
        let expectation = self.expectation(description: "Service request")
        
        self.service.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .server(500))
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmptyServerResponse() throws {
        self.httpClientMock.error = .noData
        
        let expectation = self.expectation(description: "Service request")
        
        self.service.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .emptyResponse)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNoServerResponse() throws {
        self.httpClientMock.error = .noResponse
        
        let expectation = self.expectation(description: "Service request")
        
        self.service.search(in: "Location Value") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .noResponse)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
