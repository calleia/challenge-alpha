//
//  HttpClientProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum HttpRequestError: Error {
    case client(_ description: String)
    case server(_ statusCode: Int)
    case noData
    case noResponse
}

protocol HttpClientProtocol {
    func request(url: URL, completion: @escaping (Result<Data, HttpRequestError>) -> Void)
}
