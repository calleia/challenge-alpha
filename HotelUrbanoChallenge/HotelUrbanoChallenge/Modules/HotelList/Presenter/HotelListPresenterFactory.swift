//
//  HotelListPresenterFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelListPresenterFactory {
    static func make(wireframe: HotelListWireframeProtocol) -> HotelListPresenter {
        let presenter = HotelListPresenter(wireframe: wireframe)
        
        return presenter
    }
}
