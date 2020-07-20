//
//  Suggestion.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct Suggestion: Equatable {
    let value: String
    let country: String
    let state: String
    let city: String
    let filter: String
}

extension Suggestion: Decodable {
    enum CodingKeys: String, CodingKey {
        case value = "text"
        case country
        case state
        case city
        case filter
    }
}
