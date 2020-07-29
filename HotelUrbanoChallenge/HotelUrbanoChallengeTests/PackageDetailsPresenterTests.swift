//
//  PackageDetailsPresenterTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 28/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class PackageDetailsPresenterTests: XCTestCase {
    
    private var packageDetailsViewMock: PackageDetailsViewMock!
    private var packageDetailsWireframeMock: PackageDetailsWireframeMock!
    private var httpClientMock: HttpClientMock!
    private var presenter: PackageDetailsPresenter!
    
    private var geoLocationMock: GeoLocation!
    private var addressMock: Address!
    private var priceMock: Price!
    private var galleryImageMock: GalleryImage!
    private var quantityDescriptorMock: QuantityDescriptor!
    private var amenityMock: Amenity!
    private var packageMock: Package!
    
    override func setUpWithError() throws {
        self.packageDetailsViewMock = PackageDetailsViewMock()
        self.packageDetailsWireframeMock = PackageDetailsWireframeMock()
        self.httpClientMock = HttpClientMock()
        self.presenter = PackageDetailsPresenter(wireframe: self.packageDetailsWireframeMock, httpClient: self.httpClientMock)
        self.presenter.view = self.packageDetailsViewMock
        
        self.geoLocationMock = GeoLocation(lat: 12.34, lon: 56.78)
        self.addressMock = Address(city: "Address City", state: "Address State", geoLocation: self.geoLocationMock)
        self.priceMock = Price(amountPerDay: 42.42)
        self.galleryImageMock = GalleryImage(description: "Image description", url: "http://image.url")
        self.quantityDescriptorMock = QuantityDescriptor(nights: 1, maxPeople: 2)
        self.amenityMock = Amenity(name: "Amenity Name", category: "Amenity Category")
        self.packageMock = Package(id: "Package ID",
                                   name: "Package Name",
                                   smallDescription: "Package Small Description",
                                   description: "Package Description",
                                   gallery: [self.galleryImageMock],
                                   address: self.addressMock,
                                   price: self.priceMock,
                                   quantityDescriptors: self.quantityDescriptorMock,
                                   amenities: [self.amenityMock])
    }
    
    override func tearDownWithError() throws {
        self.packageDetailsViewMock = nil
        self.packageDetailsWireframeMock = nil
        self.httpClientMock = nil
        self.presenter = nil
        
        self.geoLocationMock = nil
        self.addressMock = nil
        self.priceMock = nil
        self.galleryImageMock = nil
        self.quantityDescriptorMock = nil
        self.amenityMock = nil
        self.packageMock = nil
    }
    
    func testInitialValues() throws {
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.presenter.package, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setNameCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetName, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setSmallDescriptionCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetSmallDescription, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setDescriptionCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetDescription, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setGalleryCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetGallery, [])
        
        XCTAssertEqual(self.packageDetailsViewMock.setAddressCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetAddress, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setMapCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetLat, nil)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetLon, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setPriceCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetPrice, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setNightsCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetNights, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setMaxPeopleCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetMaxPeople, nil)
        
        XCTAssertEqual(self.packageDetailsViewMock.setAmenitiesCallCount, 0)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetAmenities, [])
    }
    
    func testSetName() throws {
        self.presenter.package = self.packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setNameCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetName, "Package Name")
    }
    
    func testSetSmallDescription() throws {
        self.presenter.package = self.packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setSmallDescriptionCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetSmallDescription, "Package Small Description")
    }
    
    func testSetDescription() throws {
        self.presenter.package = self.packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setDescriptionCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetDescription, "Package Description")
    }
    
    func testSetAddress() throws {
        self.presenter.package = self.packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setAddressCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetAddress, "Address City, Address State")
    }
    
    func testSetCity() throws {
        let addressMock = Address(city: "Address City", state: nil, geoLocation: self.geoLocationMock)
        let packageMock = Package(id: "Package ID",
                                  name: "Package Name",
                                  smallDescription: "Package Small Description",
                                  description: "Package Description",
                                  gallery: [self.galleryImageMock],
                                  address: addressMock,
                                  price: self.priceMock,
                                  quantityDescriptors: self.quantityDescriptorMock,
                                  amenities: [self.amenityMock])
        
        self.presenter.package = packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setAddressCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetAddress, "Address City")
    }
    
    func testSetState() throws {
        let addressMock = Address(city: nil, state: "Address State", geoLocation: self.geoLocationMock)
        let packageMock = Package(id: "Package ID",
                                  name: "Package Name",
                                  smallDescription: "Package Small Description",
                                  description: "Package Description",
                                  gallery: [self.galleryImageMock],
                                  address: addressMock,
                                  price: self.priceMock,
                                  quantityDescriptors: self.quantityDescriptorMock,
                                  amenities: [self.amenityMock])
        
        self.presenter.package = packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setAddressCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetAddress, "Address State")
    }
    
    func testSetPrice() throws {
        self.presenter.package = self.packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setPriceCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetPrice, "R$ 42")
    }
    
    func testSetNights() throws {
        let quantityDescriptorMock = QuantityDescriptor(nights: 2, maxPeople: 1)
        let packageMock = Package(id: "Package ID",
                                  name: "Package Name",
                                  smallDescription: "Package Small Description",
                                  description: "Package Description",
                                  gallery: [self.galleryImageMock],
                                  address: self.addressMock,
                                  price: self.priceMock,
                                  quantityDescriptors: quantityDescriptorMock,
                                  amenities: [self.amenityMock])
        
        self.presenter.package = packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setNightsCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetNights, "2 diárias")
    }
    
    func testSetSingleNight() throws {
        let quantityDescriptorMock = QuantityDescriptor(nights: 1, maxPeople: 2)
        let packageMock = Package(id: "Package ID",
                                  name: "Package Name",
                                  smallDescription: "Package Small Description",
                                  description: "Package Description",
                                  gallery: [self.galleryImageMock],
                                  address: self.addressMock,
                                  price: self.priceMock,
                                  quantityDescriptors: quantityDescriptorMock,
                                  amenities: [self.amenityMock])
        
        self.presenter.package = packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setNightsCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetNights, "1 diária")
    }
    
    func testSetMaxPeople() throws {
        let quantityDescriptorMock = QuantityDescriptor(nights: 1, maxPeople: 2)
        let packageMock = Package(id: "Package ID",
                                  name: "Package Name",
                                  smallDescription: "Package Small Description",
                                  description: "Package Description",
                                  gallery: [self.galleryImageMock],
                                  address: self.addressMock,
                                  price: self.priceMock,
                                  quantityDescriptors: quantityDescriptorMock,
                                  amenities: [self.amenityMock])
        
        self.presenter.package = packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setMaxPeopleCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetMaxPeople, "2 pessoas")
    }
    
    func testSetSingleMaxPeople() throws {
        let quantityDescriptorMock = QuantityDescriptor(nights: 2, maxPeople: 1)
        let packageMock = Package(id: "Package ID",
                                  name: "Package Name",
                                  smallDescription: "Package Small Description",
                                  description: "Package Description",
                                  gallery: [self.galleryImageMock],
                                  address: self.addressMock,
                                  price: self.priceMock,
                                  quantityDescriptors: quantityDescriptorMock,
                                  amenities: [self.amenityMock])
        
        self.presenter.package = packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setMaxPeopleCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetMaxPeople, "1 pessoa")
    }
    
    func testSetAmenities() throws {
        self.presenter.package = self.packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setAmenitiesCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetAmenities, ["Amenity Name"])
    }
    
    func testSetMap() throws {
        self.presenter.package = self.packageMock
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.packageDetailsViewMock.setMapCallCount, 1)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetLat, 12.34)
        XCTAssertEqual(self.packageDetailsViewMock.lastSetLon, 56.78)
    }
    
}
