//
//  HotelDetailsViewMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

@testable import HotelUrbanoChallenge

final class HotelDetailsViewMock: HotelDetailsView {
    
    var setNameCallCount = 0
    var lastSetName: String? = nil
    
    var setDescriptionCallCount = 0
    var lastSetDescription: String? = nil
    
    var setGalleryCallCount = 0
    var lastSetGallery: [UIImage] = []
    
    var setStarsCallCount = 0
    var lastSetStars: Int? = nil
    
    var setFreeCancellationCallCount = 0
    var lastSetFreeCancellation: Bool? = nil
    
    var setCityCallCount = 0
    var lastSetCity: String? = nil
    
    var setStateCallCount = 0
    var lastSetState: String? = nil
    
    var setPriceCallCount = 0
    var lastSetPrice: Int? = nil
    
    var setAmenitiesCallCount = 0
    var lastSetAmenities: [String] = []
    
    func setName(_ name: String) {
        self.setNameCallCount += 1
        self.lastSetName = name
    }
    
    func setDescription(_ description: String) {
        self.setDescriptionCallCount += 1
        self.lastSetDescription = description
    }
    
    func setGallery(_ image: [UIImage]) {
        self.setGalleryCallCount += 1
        self.lastSetGallery = image
    }
    
    func setStars(_ stars: Int) {
        self.setStarsCallCount += 1
        self.lastSetStars = stars
    }
    
    func setFreeCancellation(_ freeCancellation: Bool) {
        self.setFreeCancellationCallCount += 1
        self.lastSetFreeCancellation = freeCancellation
    }
    
    func setCity(_ city: String) {
        self.setCityCallCount += 1
        self.lastSetCity = city
    }
    
    func setState(_ state: String) {
        self.setStateCallCount += 1
        self.lastSetState = state
    }
    
    func setPrice(_ price: Int) {
        self.setPriceCallCount += 1
        self.lastSetPrice = price
    }
    
    func setAmenities(_ amenities: [String]) {
        self.setAmenitiesCallCount += 1
        self.lastSetAmenities = amenities
    }
}
