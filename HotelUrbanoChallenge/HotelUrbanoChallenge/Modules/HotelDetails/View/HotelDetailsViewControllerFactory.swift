//
//  HotelDetailsViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelDetailsViewControllerFactory {
    static func make(wireframe: HotelDetailsWireframeProtocol) -> HotelDetailsViewController {
        let viewController = HotelDetailsViewController()
        
        return viewController
    }
}
