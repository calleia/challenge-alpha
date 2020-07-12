//
//  GetSuggestionsInteractor.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class GetSuggestionsInteractor: GetSuggestionsInteractorProtocol {
    
    private var service: SuggestionsServiceProtocol
    
    init(service: SuggestionsServiceProtocol) {
        self.service = service
    }
    
    func suggestions(for location: String, completion: @escaping (Result<[Suggestion], GetSuggestionsError>) -> Void) {
        self.service.fetch(location) { result in
            switch result {
            case .success(let response):
                completion(.success(response.suggestions))
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
