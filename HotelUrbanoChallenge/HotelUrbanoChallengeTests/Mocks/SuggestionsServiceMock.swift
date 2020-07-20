//
//  SuggestionsServiceMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class SuggestionsServiceMock: SuggestionsServiceProtocol {
    
    var error: SuggestionsServiceError? = nil
    var response = SuggestionsServiceResponse(suggestions: [])
    
    var callCount = 0
    var lastLocation = ""
    
    func fetch(_ location: String, completion: @escaping (Result<SuggestionsServiceResponse, SuggestionsServiceError>) -> Void) {
        self.lastLocation = location
        self.callCount += 1
        
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.response))
        }
    }
}
