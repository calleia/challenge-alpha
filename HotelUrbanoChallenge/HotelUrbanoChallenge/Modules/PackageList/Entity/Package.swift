//
//  Package.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

struct Package: Equatable, Decodable {
    let id: String
    let name: String
    let smallDescription: String
    let description: String
    let gallery: [GalleryImage]
    let address: Address
    let price: Price
    let quantityDescriptors: QuantityDescriptor
    let amenities: [Amenity]
}
