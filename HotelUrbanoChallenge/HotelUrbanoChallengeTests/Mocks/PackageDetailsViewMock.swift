//
//  PackageDetailsViewMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 28/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

@testable import HotelUrbanoChallenge

final class PackageDetailsViewMock: PackageDetailsView {
    
    var setNameCallCount = 0
    var lastSetName: String? = nil
    
    var setSmallDescriptionCallCount = 0
    var lastSetSmallDescription: String? = nil
    
    var setDescriptionCallCount = 0
    var lastSetDescription: String? = nil
    
    var setGalleryCallCount = 0
    var lastSetGallery: [UIImage] = []
    
    var setAddressCallCount = 0
    var lastSetAddress: String? = nil
    
    var setMapCallCount = 0
    var lastSetLat: Float? = nil
    var lastSetLon: Float? = nil
    
    var setPriceCallCount = 0
    var lastSetPrice: String? = nil
    
    var setNightsCallCount = 0
    var lastSetNights: Int? = nil
    
    var setMaxPeopleCallCount = 0
    var lastSetMaxPeople: Int? = nil
    
    var setAmenitiesCallCount = 0
    var lastSetAmenities: [String] = []
    
    func setName(_ name: String) {
        self.setNameCallCount += 1
        self.lastSetName = name
    }
    
    func setSmallDescription(_ smallDescription: String) {
        self.setSmallDescriptionCallCount += 1
        self.lastSetSmallDescription = smallDescription
    }
    
    func setDescription(_ description: String) {
        self.setDescriptionCallCount += 1
        self.lastSetDescription = description
    }
    
    func setGallery(_ images: [UIImage]) {
        self.setGalleryCallCount += 1
        self.lastSetGallery = images
    }
    
    func setAddress(_ address: String) {
        self.setAddressCallCount += 1
        self.lastSetAddress = address
    }
    
    func setMap(lat: Float, lon: Float) {
        self.setMapCallCount += 1
        self.lastSetLat = lat
        self.lastSetLon = lon
    }
    
    func setPrice(_ price: String) {
        self.setPriceCallCount += 1
        self.lastSetPrice = price
    }
    
    func setNights(_ nights: Int) {
        self.setNightsCallCount += 1
        self.lastSetNights = nights
    }
    
    func setMaxPeople(_ maxPeople: Int) {
        self.setMaxPeopleCallCount += 1
        self.lastSetMaxPeople = maxPeople
    }
    
    func setAmenities(_ amenities: [String]) {
        self.setAmenitiesCallCount += 1
        self.lastSetAmenities = amenities
    }
    
}
