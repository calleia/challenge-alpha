//
//  HttpClientMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 28/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class HttpClientMock: HttpClientProtocol {
    
    var error: HttpRequestError? = nil
    var payload = Data()
    
    var callCount = 0
    var lastUrl: URL? = nil
    
    func request(url: URL, completion: @escaping (Result<Data, HttpRequestError>) -> Void) {
        self.lastUrl = url
        self.callCount += 1
        
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.payload))
        }
    }
}
