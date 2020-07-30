//
//  PackageSearchServiceProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum PackageServiceError: Error, Equatable {
    case couldNotParseResponse
    case connection(_ description: String)
    case server(_ statusCode: Int)
    case noResponse
    case emptyResponse
}

protocol PackageSearchServiceProtocol {
    func search(in location: String, completion: @escaping (Result<PackageServiceResponse, PackageServiceError>) -> Void)
}
