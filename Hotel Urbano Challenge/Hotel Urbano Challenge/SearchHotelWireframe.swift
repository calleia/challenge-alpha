//
//  SearchHotelWireframe.swift
//  Hotel Urbano Challenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class SearchHotelWireframe: SearchHotelWireframeProtocol {
    func present(in window: UIWindow) {
        let searchHotelViewController = SearchHotelViewControllerFactory.make()
        let navigationController = UINavigationController(rootViewController: searchHotelViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
