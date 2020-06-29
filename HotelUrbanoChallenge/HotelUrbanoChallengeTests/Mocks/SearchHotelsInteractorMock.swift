//
//  SearchHotelsInteractorMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 24/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class SearchHotelsInteractorMock: SearchHotelsInteractorProtocol {
    
    var error: HotelSearchError? = nil
    var hotels = [Hotel]()
    
    var callCount = 0
    var lastLocation = ""
    
    func search(in location: String, completion: @escaping (Result<[Hotel], HotelSearchError>) -> Void) {
        self.callCount += 1
        self.lastLocation = location
        
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.hotels))
        }
    }
    
}
