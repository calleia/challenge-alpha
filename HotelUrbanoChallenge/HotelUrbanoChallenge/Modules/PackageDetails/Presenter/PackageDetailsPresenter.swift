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
        
        let description = self.formatDescription(package.description)
        self.view?.setDescription(description)
        
        if let imageUrls = self.package?.gallery.map({ $0.url }) {
            self.loadImages(imageUrls)
        }
        
        let address = self.formatAddress(city: package.address.city, state: package.address.state)
        self.view?.setAddress(address)
        
        if let latitude = package.address.geoLocation.lat, let longitude = package.address.geoLocation.lon {
            self.view?.setMap(lat: latitude, lon: longitude)
        }
        
        let price = self.formatPrice(package.price.amountPerDay)
        self.view?.setPrice(price)
        
        let nightCount = self.formatNightCount(package.quantityDescriptors.nights)
        self.view?.setNights(nightCount)
        
        let peopleCount = self.formatPeopleCount(package.quantityDescriptors.maxPeople)
        self.view?.setMaxPeople(peopleCount)
        
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
    
    private func formatPrice(_ price: Float) -> String {
        let intPrice = Int(price)
        
        return "R$ \(intPrice)"
    }
    
    private func formatNightCount(_ nightCount: Int) -> String {
        let descriptor = nightCount > 1 ? "diárias" : "diária"
        
        return "\(nightCount) \(descriptor)"
    }
    
    private func formatPeopleCount(_ peopleCount: Int) -> String {
        let descriptor = peopleCount > 1 ? "pessoas" : "pessoa"
        
        return "\(peopleCount) \(descriptor)"
    }
    
    private func formatDescription(_ description: String) -> String {
        let descriptionLines = description.components(separatedBy: "\n")
        let cleanDescriptionLines: [String] = descriptionLines.map { substring in
            let line = String(substring)
            return self.cleanHtmlEntities(line)
        }
        
        return cleanDescriptionLines.joined(separator: "\n")
    }
    
    private func cleanHtmlEntities(_ string: String) -> String {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let cleanString = try? NSAttributedString(data: string.data(using: .utf8)!, options: options, documentAttributes: nil).string
        
        return cleanString ?? ""
    }
    
}
