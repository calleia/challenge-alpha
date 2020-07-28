//
//  HotelDetailsPresenterTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class HotelDetailsPresenterTests: XCTestCase {
    
    private var hotelDetailsViewMock: HotelDetailsViewMock!
    private var hotelDetailsWireframeMock: HotelDetailsWireframeMock!
    private var httpClientMock: HttpClientMock!
    private var presenter: HotelDetailsPresenter!
    
    private var geoLocationMock: GeoLocation!
    private var addressMock: Address!
    private var priceMock: Price!
    private var featuredItemMock: FeaturedItem!
    private var galleryImageMock: GalleryImage!
    private var hotelMock: Hotel!
    
    override func setUpWithError() throws {
        self.hotelDetailsViewMock = HotelDetailsViewMock()
        self.hotelDetailsWireframeMock = HotelDetailsWireframeMock()
        self.httpClientMock = HttpClientMock()
        self.presenter = HotelDetailsPresenter(wireframe: self.hotelDetailsWireframeMock, httpClient: self.httpClientMock)
        self.presenter.view = self.hotelDetailsViewMock
        
        self.geoLocationMock = GeoLocation(lat: 12.34, lon: 56.78)
        self.addressMock = Address(city: "Address City", state: "Address State", geoLocation: self.geoLocationMock)
        self.priceMock = Price(amountPerDay: 42.42)
        self.featuredItemMock = FeaturedItem(amenities: ["Amenity 1", "Amenity 2"])
        self.galleryImageMock = GalleryImage(description: "Image description", url: "http://image.url")
        self.hotelMock = Hotel(id: "Hotel ID",
                               name: "Hotel Name",
                               smallDescription: "Hotel Description",
                               image: "Hotel Image",
                               gallery: [self.galleryImageMock],
                               stars: 5,
                               freeCancellation: true,
                               address: self.addressMock,
                               price: self.priceMock,
                               featuredItem: self.featuredItemMock)
    }
    
    override func tearDownWithError() throws {
        self.hotelDetailsViewMock = nil
        self.hotelDetailsWireframeMock = nil
        self.httpClientMock = nil
        self.presenter = nil
        
        self.geoLocationMock = nil
        self.addressMock = nil
        self.priceMock = nil
        self.featuredItemMock = nil
        self.galleryImageMock = nil
        self.hotelMock = nil
    }
    
    func testInitialValues() throws {
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.presenter.hotel, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setNameCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetName, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setDescriptionCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetDescription, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setGalleryCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetGallery, [])
        
        XCTAssertEqual(self.hotelDetailsViewMock.setStarsCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetStars, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setFreeCancellationCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetFreeCancellation, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setCityCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetCity, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setStateCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetState, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setMapCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetLat, nil)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetLon, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setPriceCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetPrice, nil)
        
        XCTAssertEqual(self.hotelDetailsViewMock.setAmenitiesCallCount, 0)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetAmenities, [])
    }
    
    func testSetName() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setNameCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetName, "Hotel Name")
    }
    
    func testSetDescription() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setDescriptionCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetDescription, "Hotel Description")
    }
    
    func testSetStars() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setStarsCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetStars, 5)
    }
    
    func testSetFreeCancellation() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setFreeCancellationCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetFreeCancellation, true)
    }
    
    func testSetCity() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setCityCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetCity, "Address City")
    }
    
    func testSetState() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setStateCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetState, "Address State")
    }
    
    func testSetMap() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setMapCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetLat, 12.34)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetLon, 56.78)
    }
    
    func testSetPrice() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setPriceCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetPrice, 42)
    }
    
    func testSetAmenities() throws {
        self.presenter.hotel = self.hotelMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.hotelDetailsViewMock.setAmenitiesCallCount, 1)
        XCTAssertEqual(self.hotelDetailsViewMock.lastSetAmenities, ["Amenity 1", "Amenity 2"])
    }
    
}
