//
//  PackageSearchServiceMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class PackageSearchServiceMock: PackageSearchServiceProtocol {
    
    var error: PackageServiceError? = nil
    var response = PackageServiceResponse(results: [])
    
    var callCount = 0
    var lastLocation = ""
    
    func search(in location: String, completion: @escaping (Result<PackageServiceResponse, PackageServiceError>) -> Void) {
        self.lastLocation = location
        self.callCount += 1
        
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.response))
        }
    }
}
