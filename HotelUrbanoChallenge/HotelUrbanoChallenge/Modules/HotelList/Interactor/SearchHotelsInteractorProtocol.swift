//
//  SearchHotelsInteractorProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 24/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

enum HotelSearchError: Error {
    case requestTimeout
}

protocol SearchHotelsInteractorProtocol {
    func search(in location: String, completion: @escaping (Result<[String], HotelSearchError>) -> Void)
}
