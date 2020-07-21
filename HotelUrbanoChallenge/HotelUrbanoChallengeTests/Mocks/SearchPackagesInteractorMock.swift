//
//  SearchPackagesInteractorMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class SearchPackagesInteractorMock: SearchPackagesInteractorProtocol {
    
    var error: PackageSearchError? = nil
    var packages = [Package]()
    
    var callCount = 0
    var lastLocation = ""
    
    func search(in location: String, completion: @escaping (Result<[Package], PackageSearchError>) -> Void) {
        self.callCount += 1
        self.lastLocation = location
        
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.packages))
        }
    }
    
}
