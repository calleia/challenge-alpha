//
//  GetSuggestionsInteractorProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum GetSuggestionsError: Error, Equatable {
    case invalidServiceResponse
    case connection(_ description: String)
    case service(_ statusCode: Int)
}

protocol GetSuggestionsInteractorProtocol {
    func suggestions(for location: String, completion: @escaping (Result<[Suggestion], GetSuggestionsError>) -> Void)
}
