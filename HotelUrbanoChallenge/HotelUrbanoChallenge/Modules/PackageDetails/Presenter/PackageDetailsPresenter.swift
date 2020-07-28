//
//  PackageDetailsPresenter.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 28/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class PackageDetailsPresenter: PackageDetailsPresenterProtocol {
    
    private var wireframe: PackageDetailsWireframeProtocol
    private var httpClient: HttpClientProtocol!
    
    weak var view: PackageDetailsView? = nil
    
    var package: Package? = nil
    
    init(wireframe: PackageDetailsWireframeProtocol, httpClient: HttpClientProtocol) {
        self.wireframe = wireframe
        self.httpClient = httpClient
    }
    
    func viewDidLoad() {
        guard let package = self.package else {
            return
        }
        
        self.view?.setName(package.name)
        
        self.view?.setSmallDescription(package.smallDescription)
        
        self.view?.setDescription(package.description)
        
        if let imageUrls = self.package?.gallery.map({ $0.url }) {
            self.loadImages(imageUrls)
        }
        
        let address = self.formatAddress(city: package.address.city, state: package.address.state)
        self.view?.setAddress(address)
        
        if let latitude = package.address.geoLocation.lat, let longitude = package.address.geoLocation.lon {
            self.view?.setMap(lat: latitude, lon: longitude)
        }
        
        let price = Int(package.price.amountPerDay)
        self.view?.setPrice("R$ \(price)")
        
        self.view?.setNights(package.quantityDescriptors.nights)
        
        self.view?.setMaxPeople(package.quantityDescriptors.maxPeople)
        
        let amenities = package.amenities.map({ $0.name })
        self.view?.setAmenities(amenities)
    }
    
}

extension PackageDetailsPresenter {
    
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
    
    private func formatAddress(city: String? = nil, state: String? = nil) -> String {
        var address = ""
        
        if let city = city {
            address.append(city)
        }
        
        if let state = state {
            if !address.isEmpty {
                address.append(", ")
            }
            
            address.append(state)
        }
        
        return address
    }
    
}
