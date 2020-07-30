//
//  PackageListWireframe.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 21/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageListWireframe: PackageListWireframeProtocol {
    
    private var packageDetailsWireframe = PackageDetailsWireframe()
    
    weak var viewController: PackageListViewController? = nil
    
    func presentDetails(for package: Package) {
        guard let navigationController = self.viewController?.navigationController else {
            return
        }
        
        self.packageDetailsWireframe.present(package: package, in: navigationController)
    }
    
}
