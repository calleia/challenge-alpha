//
//  PackageDetailsViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 27/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageDetailsViewControllerFactory {
    static func make(wireframe: PackageDetailsWireframeProtocol, package: Package) -> PackageDetailsViewController {
        let viewController = PackageDetailsViewController()
        self.setupPresenter(viewController, wireframe: wireframe, with: package)
        
        return viewController
    }
}

extension PackageDetailsViewControllerFactory {
    private static func setupPresenter(_ viewController: PackageDetailsViewController, wireframe: PackageDetailsWireframeProtocol, with package: Package) {
        let presenter = PackageDetailsPresenterFactory.make(wireframe: wireframe)
        presenter.package = package
        presenter.view = viewController
        
        viewController.presenter = presenter
    }
}
