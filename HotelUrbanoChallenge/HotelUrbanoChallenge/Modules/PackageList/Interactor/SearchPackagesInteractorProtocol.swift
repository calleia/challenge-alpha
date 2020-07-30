//
//  SearchPackagesInteractorProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum PackageSearchError: Error, Equatable {
    case invalidServiceResponse
    case connection(_ description: String)
    case service(_ statusCode: Int)
}

protocol SearchPackagesInteractorProtocol {
    func search(in location: String, completion: @escaping (Result<[Package], PackageSearchError>) -> Void)
}
