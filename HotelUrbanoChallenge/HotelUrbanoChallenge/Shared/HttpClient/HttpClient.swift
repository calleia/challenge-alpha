//
//  HttpClient.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HttpClient {
    static func request(url: URL, completion: @escaping (Result<String, HttpRequestError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.client(error.localizedDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard response.statusCode >= 200, response.statusCode < 300 else {
                completion(.failure(.server(response.statusCode)))
                return
            }
            
            guard let data = data, let payload = String(data: data, encoding: .utf8) else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(payload))
        }
        
        task.resume()
    }
}
