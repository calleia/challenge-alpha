//
//  SearchHotelsInteractorProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 24/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum HotelSearchError: Error, Equatable {
    case invalidServiceResponse
    case connection(_ description: String)
    case service(_ statusCode: Int)
}

protocol SearchHotelsInteractorProtocol {
    func search(in location: String, completion: @escaping (Result<[Hotel], HotelSearchError>) -> Void)
}
