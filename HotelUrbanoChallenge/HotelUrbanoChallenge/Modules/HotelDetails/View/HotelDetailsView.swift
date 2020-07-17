//
//  HotelDetailsView.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

protocol HotelDetailsView: AnyObject {
    func setName(_ name: String)
    func setDescription(_ description: String)
    func setGallery(_ image: [UIImage])
    func setStars(_ stars: Int)
    func setFreeCancellation(_ freeCancellation: Bool)
    func setCity(_ city: String)
    func setState(_ state: String)
    func setMap(lat: Float, lon: Float)
    func setPrice(_ price: Int)
    func setAmenities(_ amenities: [String])
}
