//
//  PackageDetailsPresenterFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 28/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageDetailsPresenterFactory {
    static func make(wireframe: PackageDetailsWireframeProtocol) -> PackageDetailsPresenter {
        let httpClient = HttpClient()
        let presenter = PackageDetailsPresenter(wireframe: wireframe, httpClient: httpClient)
        
        return presenter
    }
}
