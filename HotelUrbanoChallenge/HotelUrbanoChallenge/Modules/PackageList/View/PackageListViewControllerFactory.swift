//
//  PackageListViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 21/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageListViewControllerFactory {
    static func make() -> PackageListViewController {
        let viewController = PackageListViewController()
        self.setupPresenter(viewController)
        
        return viewController
    }
}

extension PackageListViewControllerFactory {
    private static func setupPresenter(_ viewController: PackageListViewController) {
        let wireframe = PackageListWireframe()
        wireframe.viewController = viewController
        
        let presenter = PackageListPresenterFactory.make(wireframe: wireframe)
        presenter.view = viewController
        
        viewController.presenter = presenter
    }
}
