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
    
    private var hotelListViewMock: HotelListViewMock!
    private var hotelListWireframeMock: HotelListWireframeMock!
    private var searchHotelsInteractorMock: SearchHotelsInteractorMock!
    private var presenter: HotelListPresenter!
    
    override func setUpWithError() throws {
        self.hotelListViewMock = HotelListViewMock()
        self.hotelListWireframeMock = HotelListWireframeMock()
        self.searchHotelsInteractorMock = SearchHotelsInteractorMock()
        self.presenter = HotelListPresenter(searchHotelsInteractor: self.searchHotelsInteractorMock,
                                            wireframe: self.hotelListWireframeMock)
        self.presenter.view = self.hotelListViewMock
    }
    
    override func tearDownWithError() throws {
        self.hotelListViewMock = nil
        self.hotelListWireframeMock = nil
        self.searchHotelsInteractorMock = nil
        self.presenter = nil
    }
    
    func testInitialValues() throws {
        XCTAssertEqual(self.searchHotelsInteractorMock.callCount, 0)
        XCTAssertEqual(self.searchHotelsInteractorMock.lastLocation, "")
        
        XCTAssertEqual(self.hotelListViewMock.showActivityIndicatorCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.hideActivityIndicatorCallCount, 0)
        
        XCTAssertEqual(self.hotelListViewMock.showHotelsCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastHotelList, [])
        
        XCTAssertEqual(self.hotelListViewMock.showErrorCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastErrorMessage, "")
    }
    
    func testSearchHotels() throws {
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.searchHotelsInteractorMock.callCount, 1)
        XCTAssertEqual(self.searchHotelsInteractorMock.lastLocation, "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showActivityIndicatorCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.hideActivityIndicatorCallCount, 1)
    }
    
    func testShowHotels() throws {
        let hotelListMock = ["First Hotel",
                             "Second Hotel",
                             "Third Hotel"]
        self.searchHotelsInteractorMock.hotels = hotelListMock
        
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showHotelsCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.lastHotelList, hotelListMock)
        
        XCTAssertEqual(self.hotelListViewMock.showErrorCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastErrorMessage, "")
    }
    
    func testShowError() throws {
        self.searchHotelsInteractorMock.error = .requestTimeout
        
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showHotelsCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastHotelList, [])
        
        XCTAssertEqual(self.hotelListViewMock.showErrorCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.lastErrorMessage, "Request timeout, por favor tente novamente.")
    }
    
}
