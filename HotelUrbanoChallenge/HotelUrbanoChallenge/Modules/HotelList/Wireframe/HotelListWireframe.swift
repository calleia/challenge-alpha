//
//  HotelListWireframe.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelListWireframe: HotelListWireframeProtocol {
    
    private var hotelDetailsWireframe = HotelDetailsWireframe()
    
    private var navigationController: UINavigationController? = nil
    
    func present(in window: UIWindow) {
        let hotelListViewController = HotelListViewControllerFactory.make(wireframe: self)
        self.navigationController = UINavigationController(rootViewController: hotelListViewController)
        
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    func presentDetails(for hotel: Hotel) {
        guard let navigationController = self.navigationController else {
            return
        }
        
        self.hotelDetailsWireframe.present(in: navigationController)
    }
}
