//
//  HotelListWireframe.swift
//  Hotel Urbano Challenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelListWireframe: HotelListWireframeProtocol {
    func present(in window: UIWindow) {
        let hotelListViewController = HotelListViewControllerFactory.make(wireframe: self)
        let navigationController = UINavigationController(rootViewController: hotelListViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
