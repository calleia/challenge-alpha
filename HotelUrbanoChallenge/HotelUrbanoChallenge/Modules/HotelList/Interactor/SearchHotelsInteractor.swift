//
//  SearchHotelsInteractor.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 24/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SearchHotelsInteractor: SearchHotelsInteractorProtocol {
    
    private var service: HotelSearchServiceProtocol
    
    init(service: HotelSearchServiceProtocol) {
        self.service = service
    }
    
    func search(in location: String, completion: @escaping (Result<[String], HotelSearchError>) -> Void) {
        self.service.search(in: location) { result in
            switch result {
            case .success(let hotels):
                completion(.success(hotels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
