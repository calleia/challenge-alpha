//
//  HotelListWireframeMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 24/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

@testable import HotelUrbanoChallenge

final class HotelListWireframeMock: HotelListWireframeProtocol {
    
    var presentDetailsCallCount = 0
    var lastPresentedDetails: Hotel? = nil
    
    func present(in window: UIWindow) {}
    
    func presentDetails(for hotel: Hotel) {
        self.presentDetailsCallCount += 1
        self.lastPresentedDetails = hotel
    }
}
