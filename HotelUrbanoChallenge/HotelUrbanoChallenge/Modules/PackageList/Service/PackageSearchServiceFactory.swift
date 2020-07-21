//
//  PackageSearchServiceFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageSearchServiceFactory {
    static func make() -> PackageSearchService {
        let httpClient = HttpClient()
        let service = PackageSearchService(httpClient: httpClient)
        
        return service
    }
}
