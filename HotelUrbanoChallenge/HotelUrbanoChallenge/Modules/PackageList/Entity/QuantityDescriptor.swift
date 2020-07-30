//
//  QuantityDescriptor.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 24/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct QuantityDescriptor: Decodable, Equatable {
    let nights: Int
    let maxPeople: Int
}
