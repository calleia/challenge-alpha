//
//  GetSuggestionsInteractorFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class GetSuggestionsInteractorFactory {
    static func make() -> GetSuggestionsInteractor {
        let suggestionsService = SuggestionsServiceFactory.make()
        let interactor = GetSuggestionsInteractor(service: suggestionsService)
        
        return interactor
    }
}
