//
//  HotelSearchServiceProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum HotelServiceError: Error, Equatable {
    case couldNotParseResponse
    case connection(_ description: String)
    case server(_ statusCode: Int)
    case noResponse
    case emptyResponse
}

protocol HotelSearchServiceProtocol {
    func search(in location: String, completion: @escaping (Result<HotelServiceResponse, HotelServiceError>) -> Void)
}
