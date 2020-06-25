//
//  HotelListPresenterTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 24/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class HotelListPresenterTests: XCTestCase {
    
    private var hotelListWireframeMock: HotelListWireframeMock!
    private var presenter: HotelListPresenterProtocol!
    
    override func setUpWithError() throws {
        self.hotelListWireframeMock = HotelListWireframeMock()
        self.presenter = HotelListPresenter(wireframe: self.hotelListWireframeMock)
    }

    override func tearDownWithError() throws {
        self.hotelListWireframeMock = nil
        self.presenter = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
