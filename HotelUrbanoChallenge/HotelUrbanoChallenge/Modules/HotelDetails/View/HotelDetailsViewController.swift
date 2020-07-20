//
//  HotelDetailsViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var starStackView: UIStackView!
    
    @IBOutlet weak var amenitiesStackView: UIStackView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var freeCancellationLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var presenter: HotelDetailsPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
}

extension HotelDetailsViewController: HotelDetailsView {
    func setName(_ name: String) {
        self.nameLabel.text = name
    }
    
    func setDescription(_ description: String) {
        self.descriptionLabel.text = description
    }
    
    func setGallery(_ image: [UIImage]) {
        // TODO
    }
    
    func setStars(_ stars: Int) {
        for (index, starView) in self.starStackView.arrangedSubviews.enumerated() {
            if index < stars {
                starView.isHidden = false
            } else {
                starView.isHidden = true
            }
        }
    }
    
    func setFreeCancellation(_ freeCancellation: Bool) {
        self.freeCancellationLabel.isHidden = !freeCancellation
    }
    
    func setCity(_ city: String) {
        self.addressLabel.text = city
    }
    
    func setState(_ state: String) {
        if self.addressLabel.text != nil {
            self.addressLabel.text?.append(", \(state)")
        } else {
            self.addressLabel.text = state
        }
    }
    
    func setMap(lat: Float, lon: Float) {
        // TODO
    }
    
    func setPrice(_ price: Int) {
        self.priceLabel.text = "R$ \(Int(price))"
    }
    
    func setAmenities(_ amenities: [String]) {
        amenities.forEach { amenity in
            let label = UILabel()
            label.text = "- \(amenity)"
            label.font = label.font.withSize(15.0)
            self.amenitiesStackView.addArrangedSubview(label)
        }
    }
}
