//
//  SearchHotelViewControllerFactory.swift
//  Hotel Urbano Challenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SearchHotelViewControllerFactory {
    static func make(wireframe: SearchHotelWireframeProtocol) -> SearchHotelViewController {
        let viewController = SearchHotelViewController()
        
        let presenter = SearchHotelPresenterFactory.make(wireframe: wireframe)
        presenter.view = viewController
        
        viewController.presenter = presenter
        
        return viewController
    }
}
