//
//  PackageDetailsWireframe.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 27/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class PackageDetailsWireframe: PackageDetailsWireframeProtocol {
    
    func present(package: Package, in navigationController: UINavigationController) {
        let viewController = PackageDetailsViewControllerFactory.make(wireframe: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
