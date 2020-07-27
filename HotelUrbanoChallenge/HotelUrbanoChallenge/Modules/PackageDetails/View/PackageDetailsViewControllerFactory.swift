//
//  PackageDetailsViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 27/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageDetailsViewControllerFactory {
    static func make(wireframe: PackageDetailsWireframeProtocol) -> PackageDetailsViewController {
        let viewController = PackageDetailsViewController()
        
        return viewController
    }
}
