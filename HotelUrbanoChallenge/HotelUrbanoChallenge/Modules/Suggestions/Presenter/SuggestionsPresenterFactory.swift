//
//  SuggestionsPresenterFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SuggestionsPresenterFactory {
    static func make() -> SuggestionsPresenter {
        let presenter = SuggestionsPresenter()
        
        return presenter
    }
}
