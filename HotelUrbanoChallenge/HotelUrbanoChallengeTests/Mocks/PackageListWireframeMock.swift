//
//  PackageListWireframeMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class PackageListWireframeMock: PackageListWireframeProtocol {
    
    var presentDetailsCallCount = 0
    var lastPresentedDetails: Package? = nil
    
    func presentDetails(for package: Package) {
        self.presentDetailsCallCount += 1
        self.lastPresentedDetails = package
    }
}
