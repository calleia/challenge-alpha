//
//  HotelDetailsWireframe.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelDetailsWireframe: HotelDetailsWireframeProtocol {
    
    let viewController = HotelDetailsViewController()
    
    func present(in navigationController: UINavigationController) {
        navigationController.pushViewController(self.viewController, animated: true)
    }
}
