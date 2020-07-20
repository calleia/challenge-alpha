//
//  Address.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 15/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct Address: Decodable, Equatable {
    let city: String?
    let state: String?
    let geoLocation: GeoLocation
}
