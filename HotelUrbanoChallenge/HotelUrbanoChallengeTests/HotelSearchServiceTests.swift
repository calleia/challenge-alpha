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
    
    private var service: HotelSearchService!

    override func setUpWithError() throws {
        self.service = HotelSearchService()
    }
    
    override func tearDownWithError() throws {
        self.service = nil
    }
    
    func testService() throws {
        self.service.search(in: "Location Value") { result in
        }
    }
    
}
