//
//  PackageDetailsViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 27/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class PackageDetailsViewController: UIViewController {
    
    var presenter: PackageDetailsPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
}

extension PackageDetailsViewController: PackageDetailsView {
    
    func setName(_ name: String) {
        // TODO: set name
    }
    
    func setSmallDescription(_ smallDescription: String) {
        // TODO: set small description
    }
    
    func setDescription(_ description: String) {
        // TODO: set description
    }
    
    func setGallery(_ images: [UIImage]) {
        // TODO: set gallery
    }
    
    func setAddress(_ address: String) {
        // TODO: set address
    }
    
    func setMap(lat: Float, lon: Float) {
        // TODO: set map
    }
    
    func setPrice(_ price: String) {
        // TODO: set price
    }
    
    func setNights(_ nights: Int) {
        // TODO: set nights
    }
    
    func setMaxPeople(_ maxPeople: Int) {
        // TODO: set max people
    }
    
    func setAmenities(_ amenities: [String]) {
        // TODO: set amenities
    }
    
}
