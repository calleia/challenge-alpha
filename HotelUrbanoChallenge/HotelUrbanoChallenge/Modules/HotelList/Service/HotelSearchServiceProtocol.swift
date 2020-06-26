//
//  HotelSearchServiceProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 25/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

protocol HotelSearchServiceProtocol {
    func search(in location: String, completion: @escaping (Result<[String], HotelSearchError>) -> Void)
}
