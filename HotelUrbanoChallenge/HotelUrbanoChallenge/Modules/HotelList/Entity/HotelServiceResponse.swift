//
//  HotelServiceResponse.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 28/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct HotelServiceResponse: Decodable {
    let results: [Hotel]
}
