//
//  SearchPackagesInteractorTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class SearchPackagesInteractorTests: XCTestCase {
    
    private var packageSearchServiceMock: PackageSearchServiceMock!
    private var interactor: SearchPackagesInteractor!
    
    override func setUpWithError() throws {
        self.packageSearchServiceMock = PackageSearchServiceMock()
        self.interactor = SearchPackagesInteractor(service: self.packageSearchServiceMock)
    }
    
    override func tearDownWithError() throws {
        self.packageSearchServiceMock = nil
        self.interactor = nil
    }
    
    func testInitialValues() throws {
        XCTAssertEqual(self.packageSearchServiceMock.callCount, 0)
        XCTAssertEqual(self.packageSearchServiceMock.lastLocation, "")
    }
    
    func testServiceRequest() throws {
        self.interactor.search(in: "Location Value") { _ in }
        
        XCTAssertEqual(self.packageSearchServiceMock.callCount, 1)
        XCTAssertEqual(self.packageSearchServiceMock.lastLocation, "Location Value")
    }
    
    func testServiceFindPackages() throws {
        let geoLocation = GeoLocation(lat: 12.34, lon: 56.78)
        let address = Address(city: "Address City", state: "Address State", geoLocation: geoLocation)
        let price = Price(amountPerDay: 42.0)
        let amenity = Amenity(name: "Amenity Name", category: "Amenity Category")
        let package = Package(id: "Package ID",
                              name: "Package Name",
                              smallDescription: "Package Small Description",
                              description: "Package Description",
                              gallery: [],
                              address: address,
                              price: price,
                              amenities: [amenity])
        self.packageSearchServiceMock.response = PackageServiceResponse(results: [package])
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(let packages):
                XCTAssertEqual(packages, [package])
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceCouldNotFindPackages() throws {
        self.packageSearchServiceMock.response = PackageServiceResponse(results: [])
        
        let expectation = self.expectation(description: "Service request")
        
        self.interactor.search(in: "Location Value") { result in
            switch result {
            case .success(let packages):
                XCTAssertEqual(packages, [])
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testServiceResponseParseError() throws {
        self.packageSearchServiceMock.error = .couldNotParseResponse
        
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
        self.packageSearchServiceMock.error = .connection("Falha na conexão")
        
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
        self.packageSearchServiceMock.error = .server(500)
        
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
        self.packageSearchServiceMock.error = .noResponse
        
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
        self.packageSearchServiceMock.error = .emptyResponse
        
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
            case .success(let packages):
                XCTAssertEqual(packages, [])
                XCTAssertEqual(self.packageSearchServiceMock.callCount, 0)
            case .failure(_):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    
    
    
    
}
