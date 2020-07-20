//
//  SuggestionsServiceProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum SuggestionsServiceError: Error, Equatable {
    case couldNotParseResponse
    case connection(_ description: String)
    case server(_ statusCode: Int)
    case noResponse
    case emptyResponse
}

protocol SuggestionsServiceProtocol {
    func fetch(_ location: String, completion: @escaping (Result<SuggestionsServiceResponse, SuggestionsServiceError>) -> Void)
}
