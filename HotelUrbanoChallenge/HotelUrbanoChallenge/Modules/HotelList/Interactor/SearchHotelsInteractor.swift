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
    
    func search(in location: String, completion: @escaping (Result<[Hotel], HotelSearchError>) -> Void) {
        self.service.search(in: location) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                switch error {
                case .couldNotParseResponse:
                    completion(.failure(.invalidServiceResponse))
                case .connection(let description):
                    completion(.failure(.connection(description)))
                case .server(let statusCode):
                    completion(.failure(.service(statusCode)))
                case .noResponse:
                    completion(.failure(.invalidServiceResponse))
                case .emptyResponse:
                    completion(.failure(.invalidServiceResponse))
                }
            }
        }
    }
}
