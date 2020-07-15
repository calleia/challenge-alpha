//
//  Hotel.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 28/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct Hotel: Decodable, Equatable {
    let id: String
    let name: String
    let image: String
    let stars: Int
}
