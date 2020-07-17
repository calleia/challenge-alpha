//
//  HotelDetailsWireframe.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelDetailsWireframe: HotelDetailsWireframeProtocol {
    
    func present(in navigationController: UINavigationController) {
        let viewController = HotelDetailsViewControllerFactory.make(wireframe: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
