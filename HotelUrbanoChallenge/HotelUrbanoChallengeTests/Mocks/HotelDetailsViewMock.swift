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
    
    var setImageCallCount = 0
    var lastSetImage: UIImage? = nil
    
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
    
    func setName(_ name: String) {
        self.setNameCallCount += 1
        self.lastSetName = name
    }
    
    func setImage(_ image: UIImage) {
        self.setImageCallCount += 1
        self.lastSetImage = image
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
}
