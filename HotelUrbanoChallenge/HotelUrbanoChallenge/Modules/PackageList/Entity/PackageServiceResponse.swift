//
//  PackageServiceResponse.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct PackageServiceResponse: Decodable {
    let results: [Package]
}
