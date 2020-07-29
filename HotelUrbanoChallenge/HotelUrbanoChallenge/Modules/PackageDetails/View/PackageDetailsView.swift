//
//  PackageDetailsView.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 27/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

protocol PackageDetailsView: AnyObject {
    func setName(_ name: String)
    func setSmallDescription(_ smallDescription: String)
    func setDescription(_ description: String)
    func setGallery(_ images: [UIImage])
    func setAddress(_ address: String)
    func setMap(lat: Float, lon: Float)
    func setPrice(_ price: String)
    func setNights(_ nights: String)
    func setMaxPeople(_ maxPeople: String)
    func setAmenities(_ amenities: [String])
}
