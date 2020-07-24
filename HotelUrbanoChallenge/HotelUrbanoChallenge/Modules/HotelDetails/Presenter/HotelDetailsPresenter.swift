//
//  HotelDetailsPresenter.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelDetailsPresenter: HotelDetailsPresenterProtocol {
    
    private var wireframe: HotelDetailsWireframeProtocol
    private var httpClient: HttpClientProtocol!
    
    weak var view: HotelDetailsView? = nil
    
    var hotel: Hotel? = nil
    
    init(wireframe: HotelDetailsWireframeProtocol, httpClient: HttpClientProtocol) {
        self.wireframe = wireframe
        self.httpClient = httpClient
    }
    
    func viewDidLoad() {
        guard let hotel = self.hotel else {
            return
        }
        
        self.view?.setName(hotel.name)
        
        self.view?.setDescription(hotel.smallDescription)
        
        if let imageUrls = self.hotel?.gallery.map({ $0.url }) {
            self.loadImages(imageUrls)
        }
        
        self.view?.setStars(hotel.stars)
        
        self.view?.setFreeCancellation(hotel.freeCancellation)
        
        if let city = hotel.address.city {
            self.view?.setCity(city)
        }
        
        if let state = hotel.address.state {
            self.view?.setState(state)
        }
        
        if let latitude = hotel.address.geoLocation.lat, let longitude = hotel.address.geoLocation.lon {
            self.view?.setMap(lat: latitude, lon: longitude)
        }
        
        let price = Int(hotel.price.amountPerDay)
        self.view?.setPrice(price)
        
        if hotel.featuredItem.amenities.count > 0 {
            self.view?.setAmenities(hotel.featuredItem.amenities)
        }
    }
}

extension HotelDetailsPresenter {
    
    private func loadImages(_ urlStrings: [String]) {
        var images = [UIImage]()
        let safeUrls = urlStrings.compactMap({ $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) })
        let urls = safeUrls.compactMap({ URL(string: $0) })
        
        let semaphore = DispatchSemaphore(value: 1)
        let group = DispatchGroup()
        
        urls.forEach { url in
            group.enter()
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.httpClient.request(url: url) { result in
                    switch result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            break
                        }
                        
                        semaphore.wait()
                        images.append(image)
                        semaphore.signal()
                    case .failure(_):
                        break
                    }
                    
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .global(qos: .userInitiated)) {
            guard !images.isEmpty else {
                return
            }
            
            self.view?.setGallery(images)
        }
    }
    
}
