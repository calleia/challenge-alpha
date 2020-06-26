//
//  SearchHotelsInteractorFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SearchHotelsInteractorFactory {
    static func make() -> SearchHotelsInteractor {
        let hotelSearchService = HotelSearchService()
        let interactor = SearchHotelsInteractor(service: hotelSearchService)
        
        return interactor
    }
}
