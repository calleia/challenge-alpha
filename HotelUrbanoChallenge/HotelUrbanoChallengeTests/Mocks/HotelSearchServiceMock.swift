//
//  HotelSearchServiceMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class HotelSearchServiceMock: HotelSearchServiceProtocol {
    
    var error: HotelServiceError? = nil
    var response = Response(results: [])
    
    var callCount = 0
    var lastLocation = ""
    
    func search(in location: String, completion: @escaping (Result<Response, HotelServiceError>) -> Void) {
        self.lastLocation = location
        self.callCount += 1
        
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.response))
        }
    }
}
