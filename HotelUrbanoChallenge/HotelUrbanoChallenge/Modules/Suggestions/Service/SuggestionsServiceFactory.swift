//
//  SuggestionsServiceFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SuggestionsServiceFactory {
    static func make() -> SuggestionsService {
        let httpClient = HttpClient()
        let service = SuggestionsService(httpClient: httpClient)
        
        return service
    }
}
