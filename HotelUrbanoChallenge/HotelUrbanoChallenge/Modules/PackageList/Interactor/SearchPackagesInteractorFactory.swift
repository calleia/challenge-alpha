//
//  SearchPackagesInteractorFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SearchPackagesInteractorFactory {
    static func make() -> SearchPackagesInteractor {
        let packageSearchService = PackageSearchServiceFactory.make()
        let interactor = SearchPackagesInteractor(service: packageSearchService)
        
        return interactor
    }
}
