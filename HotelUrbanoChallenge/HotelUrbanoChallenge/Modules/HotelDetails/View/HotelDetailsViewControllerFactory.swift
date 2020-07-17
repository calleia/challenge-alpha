//
//  HotelDetailsViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelDetailsViewControllerFactory {
    static func make(wireframe: HotelDetailsWireframeProtocol, hotel: Hotel) -> HotelDetailsViewController {
        let viewController = HotelDetailsViewController()
        self.setupPresenter(viewController, wireframe: wireframe, with: hotel)
        
        return viewController
    }
}

extension HotelDetailsViewControllerFactory {
    private static func setupPresenter(_ viewController: HotelDetailsViewController, wireframe: HotelDetailsWireframeProtocol, with hotel: Hotel) {
        let presenter = HotelDetailsPresenter(wireframe: wireframe)
        presenter.hotel = hotel
        presenter.view = viewController
        
        viewController.presenter = presenter
    }
}
