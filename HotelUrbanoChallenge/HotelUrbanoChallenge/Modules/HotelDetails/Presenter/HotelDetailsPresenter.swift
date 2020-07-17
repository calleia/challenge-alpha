//
//  HotelDetailsPresenter.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelDetailsPresenter: HotelDetailsPresenterProtocol {
    
    private var wireframe: HotelDetailsWireframeProtocol
    
    weak var view: HotelDetailsView? = nil
    
    var hotel: Hotel? = nil
    
    init(wireframe: HotelDetailsWireframeProtocol) {
        self.wireframe = wireframe
    }
    
    func viewDidLoad() {
        guard let hotel = self.hotel else {
            return
        }
        
        self.view?.setName(hotel.name)
        
        self.view?.setDescription(hotel.smallDescription)
        
        // TODO: set gallery images
        // self.view?.setGallery()
        
        self.view?.setStars(hotel.stars)
        
        self.view?.setFreeCancellation(hotel.freeCancellation)
        
        if let city = hotel.address.city {
            self.view?.setCity(city)
        }
        
        if let state = hotel.address.state {
            self.view?.setState(state)
        }
        
        self.view?.setMap(lat: hotel.address.geoLocation.lat, lon: hotel.address.geoLocation.lon)
        
        let price = Int(hotel.price.amountPerDay)
        self.view?.setPrice(price)
        
        if hotel.featuredItem.amenities.count > 0 {
            self.view?.setAmenities(hotel.featuredItem.amenities)
        }
    }
}
