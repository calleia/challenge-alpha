//
//  Hotel.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 28/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct Hotel: Equatable {
    let id: String
    let name: String
    let smallDescription: String
    let image: String
    let gallery: [GalleryImage]
    let stars: Int
    let freeCancellation: Bool
    let address: Address
    let price: Price
}

extension Hotel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case smallDescription
        case image
        case gallery
        case stars
        case freeCancellation = "hu_free_cancellation"
        case address
        case price
    }
}
