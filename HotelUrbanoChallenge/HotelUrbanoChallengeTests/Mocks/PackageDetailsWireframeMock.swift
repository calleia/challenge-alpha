//
//  PackageDetailsWireframeMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 28/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

@testable import HotelUrbanoChallenge

final class PackageDetailsWireframeMock: PackageDetailsWireframeProtocol {
    func present(package: Package, in navigationController: UINavigationController) {}
}
