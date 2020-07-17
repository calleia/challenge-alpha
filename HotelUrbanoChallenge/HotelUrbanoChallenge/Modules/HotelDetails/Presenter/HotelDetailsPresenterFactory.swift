//
//  HotelDetailsPresenterFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 17/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelDetailsPresenterFactory {
    static func make(wireframe: HotelDetailsWireframeProtocol) -> HotelDetailsPresenter {
        let presenter = HotelDetailsPresenter(wireframe: wireframe)
        
        return presenter
    }
}
