//
//  HotelSearchService.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelSearchService: HotelSearchServiceProtocol {
    private var httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }
    
    func search(in location: String, completion: @escaping (Result<Response, HotelServiceError>) -> Void) {
        let query = self.cleanString(location)
        let url = self.makeUrl(with: query)
        
        self.httpClient.request(url: url) { result in
            switch result {
            case .success(let data):
                guard let response: Response = try? JSONDecoder().decode(Response.self, from: data) else {
                    completion(.failure(.couldNotParseResponse))
                    return
                }
                
                completion(.success(response))
            case .failure(let error):
                switch error {
                case .client(let description):
                    completion(.failure(.connection(description)))
                case .server(let statusCode):
                    completion(.failure(.server(statusCode)))
                case .noData:
                    completion(.failure(.emptyResponse))
                case .noResponse:
                    completion(.failure(.noResponse))
                }
            }
        }
    }
}

extension HotelSearchService {
    private func cleanString(_ value: String) -> String {
        let cleanString = value.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return cleanString.lowercased()
    }
    
    private func makeUrl(with query: String) -> URL {
        // Parse URLs based on RFC 3986 & automatically add percent encoding
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.hurb.com"
        urlComponents.path = "/search/api"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: "1")
        ]
        
        return urlComponents.url!
    }
}
