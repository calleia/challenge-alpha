//
//  HotelListViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelListViewControllerFactory {
    static func make(wireframe: HotelListWireframeProtocol) -> HotelListViewController {
        let viewController = HotelListViewController()
        
        let presenter = HotelListPresenterFactory.make(wireframe: wireframe)
        presenter.view = viewController
        
        viewController.presenter = presenter
        
        return viewController
    }
}
