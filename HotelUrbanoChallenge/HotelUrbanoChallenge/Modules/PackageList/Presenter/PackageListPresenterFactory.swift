//
//  PackageListPresenterFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageListPresenterFactory {
    static func make(wireframe: PackageListWireframeProtocol) -> PackageListPresenter {
        let searchPackagesInteractor = SearchPackagesInteractorFactory.make()
        let getSuggestionsInteractor = GetSuggestionsInteractorFactory.make()
        let presenter = PackageListPresenter(searchPackagesInteractor: searchPackagesInteractor,
                                             getSuggestionsInteractor: getSuggestionsInteractor,
                                             wireframe: wireframe)
        
        return presenter
    }
}
