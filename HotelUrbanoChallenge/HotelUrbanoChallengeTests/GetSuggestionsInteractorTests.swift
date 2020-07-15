//
//  GetSuggestionsInteractorTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class GetSuggestionsInteractorTests: XCTestCase {
    
    private var suggestionsServiceMock: SuggestionsServiceMock!
    private var interactor: GetSuggestionsInteractor!
    
    override func setUpWithError() throws {
        self.suggestionsServiceMock = SuggestionsServiceMock()
        self.interactor = GetSuggestionsInteractor(service: self.suggestionsServiceMock)
    }
    
    override func tearDownWithError() throws {
        self.suggestionsServiceMock = nil
        self.interactor = nil
    }
    
    func testInitialValues() throws {
        XCTAssertEqual(self.suggestionsServiceMock.callCount, 0)
        XCTAssertEqual(self.suggestionsServiceMock.lastLocation, "")
    }
    
    func testServiceRequest() throws {
        self.interactor.suggestions(for: "Location Value") { _ in }
        
        XCTAssertEqual(self.suggestionsServiceMock.callCount, 1)
        XCTAssertEqual(self.suggestionsServiceMock.lastLocation, "Location Value")
    }
    
    func testServiceFindSuggestions() throws {
        let suggestion = Suggestion(value: "Suggestion Mock", country: "", state: "", city: "", filter: "")
        self.suggestionsServiceMock.response = SuggestionsServiceResponse(suggestions: [suggestion])
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "Location Value") { result in
            switch result {
            case .success(let suggestions):
                XCTAssertEqual(suggestions, [suggestion])
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceCouldNotFindSuggestions() throws {
        self.suggestionsServiceMock.response = SuggestionsServiceResponse(suggestions: [])
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "Location Value") { result in
            switch result {
            case .success(let suggestions):
                XCTAssertEqual(suggestions, [])
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceResponseParseError() throws {
        self.suggestionsServiceMock.error = .couldNotParseResponse
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "Location Value") { result in
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
        self.suggestionsServiceMock.error = .connection("Falha na conexão")
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "Location Value") { result in
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
        self.suggestionsServiceMock.error = .server(500)
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "Location Value") { result in
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
        self.suggestionsServiceMock.error = .noResponse
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "Location Value") { result in
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
        self.suggestionsServiceMock.error = .emptyResponse
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "Location Value") { result in
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
    
    func testSuggestionsForEmptyLocation() throws {
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.suggestions(for: "") { result in
            switch result {
            case .success(let suggestions):
                XCTAssertEqual(suggestions, [])
                XCTAssertEqual(self.suggestionsServiceMock.callCount, 0)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
