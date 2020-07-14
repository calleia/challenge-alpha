//
//  GetSuggestionsInteractorMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class GetSuggestionsInteractorMock: GetSuggestionsInteractorProtocol {
    
    var error: GetSuggestionsError? = nil
    var suggestions = [Suggestion]()
    
    var callCount = 0
    var lastLocation = ""
    
    func suggestions(for location: String, completion: @escaping (Result<[Suggestion], GetSuggestionsError>) -> Void) {
        self.callCount += 1
        self.lastLocation = location
        
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.suggestions))
        }
    }
    
}
