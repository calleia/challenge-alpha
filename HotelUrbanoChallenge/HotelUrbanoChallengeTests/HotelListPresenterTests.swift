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
    private var getSuggestionsInteractorMock: GetSuggestionsInteractorMock!
    private var presenter: HotelListPresenter!
    
    override func setUpWithError() throws {
        self.hotelListViewMock = HotelListViewMock()
        self.hotelListWireframeMock = HotelListWireframeMock()
        self.searchHotelsInteractorMock = SearchHotelsInteractorMock()
        self.getSuggestionsInteractorMock = GetSuggestionsInteractorMock()
        self.presenter = HotelListPresenter(searchHotelsInteractor: self.searchHotelsInteractorMock,
                                            getSuggestionsInteractor: self.getSuggestionsInteractorMock,
                                            wireframe: self.hotelListWireframeMock)
        self.presenter.view = self.hotelListViewMock
    }
    
    override func tearDownWithError() throws {
        self.hotelListViewMock = nil
        self.hotelListWireframeMock = nil
        self.searchHotelsInteractorMock = nil
        self.getSuggestionsInteractorMock = nil
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
        
        XCTAssertEqual(self.getSuggestionsInteractorMock.callCount, 0)
        XCTAssertEqual(self.getSuggestionsInteractorMock.lastLocation, "")
    }
    
    func testSearchHotels() throws {
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.searchHotelsInteractorMock.callCount, 1)
        XCTAssertEqual(self.searchHotelsInteractorMock.lastLocation, "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showActivityIndicatorCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.hideActivityIndicatorCallCount, 1)
    }
    
    func testShowHotels() throws {
        let address = Address(city: "Address City", state: "Address State")
        let price = Price(amountPerDay: 42.0)
        let hotel = Hotel(id: "Hotel ID",
                          name: "Hotel Name",
                          image: "Hotel Image",
                          stars: 5,
                          address: address,
                          price: price)
        self.searchHotelsInteractorMock.hotels = [hotel]
        
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showHotelsCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.lastHotelList, [hotel])
        
        XCTAssertEqual(self.hotelListViewMock.showErrorCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastErrorMessage, "")
    }
    
    func testShowResponseError() throws {
        self.searchHotelsInteractorMock.error = .invalidServiceResponse
        
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showHotelsCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastHotelList, [])
        
        XCTAssertEqual(self.hotelListViewMock.showErrorCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.lastErrorMessage, "O serviço retornou dados inválidos, por favor tente novamente.")
    }
    
    func testShowConnectionError() throws {
        self.searchHotelsInteractorMock.error = .connection("Falha na conexão")
        
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showHotelsCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastHotelList, [])
        
        XCTAssertEqual(self.hotelListViewMock.showErrorCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.lastErrorMessage, "Falha na conexão com o serviço, por favor tente novamente.")
    }
    
    func testShowServiceError() throws {
        self.searchHotelsInteractorMock.error = .service(500)
        
        self.presenter.searchHotels(in: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showHotelsCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastHotelList, [])
        
        XCTAssertEqual(self.hotelListViewMock.showErrorCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.lastErrorMessage, "Ocorreu uma falha no servidor (código: 500). Por favor tente novamente.")
    }
    
    func testRequestSuggestions() throws {
        self.presenter.getSuggestions(for: "Location Value")
        
        XCTAssertEqual(self.getSuggestionsInteractorMock.callCount, 1)
        XCTAssertEqual(self.getSuggestionsInteractorMock.lastLocation, "Location Value")
    }
    
    func testShowSuggestions() throws {
        let suggestionMock = Suggestion(value: "Suggestion Value", country: "", state: "", city: "", filter: "")
        self.getSuggestionsInteractorMock.suggestions = [suggestionMock]
        
        self.presenter.getSuggestions(for: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showSuggestionsCallCount, 1)
        XCTAssertEqual(self.hotelListViewMock.lastSuggestions, ["Suggestion Value"])
    }
    
    func testSuggestionsServiceError() throws {
        self.getSuggestionsInteractorMock.error = .invalidServiceResponse
        
        self.presenter.getSuggestions(for: "Location Value")
        
        XCTAssertEqual(self.hotelListViewMock.showSuggestionsCallCount, 0)
        XCTAssertEqual(self.hotelListViewMock.lastSuggestions, [])
    }
    
}
