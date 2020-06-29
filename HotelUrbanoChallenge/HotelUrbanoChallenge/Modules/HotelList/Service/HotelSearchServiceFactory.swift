//
//  HotelSearchServiceFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 28/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelSearchServiceFactory {
    static func make() -> HotelSearchService {
        let httpClient = HttpClient()
        let service = HotelSearchService(httpClient: httpClient)
        
        return service
    }
}
