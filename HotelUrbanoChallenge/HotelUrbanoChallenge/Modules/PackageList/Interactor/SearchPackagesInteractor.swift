//
//  SearchPackagesInteractor.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SearchPackagesInteractor: SearchPackagesInteractorProtocol {
    
    private var service: PackageSearchServiceProtocol
    
    init(service: PackageSearchServiceProtocol) {
        self.service = service
    }
    
    func search(in location: String, completion: @escaping (Result<[Package], PackageSearchError>) -> Void) {
        guard !location.isEmpty else {
            completion(.success([]))
            return
        }
        
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
