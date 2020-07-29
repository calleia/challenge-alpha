//
//  PackageDetailsViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 27/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit
import MapKit

final class PackageDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var smallDescriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var amenitiesStackView: UIStackView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var nightCountLabel: UILabel!
    
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: PackageDetailsPresenterProtocol? = nil
    
    private var images = [UIImage]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ImageCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ImageCell.identifier)
        
        self.presenter?.viewDidLoad()
    }
    
}

extension PackageDetailsViewController: PackageDetailsView {
    
    func setName(_ name: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = name
            self.nameLabel.text = name
        }
    }
    
    func setSmallDescription(_ smallDescription: String) {
        DispatchQueue.main.async {
            self.smallDescriptionLabel.text = smallDescription
        }
    }
    
    func setDescription(_ description: String) {
        DispatchQueue.main.async {
            self.descriptionLabel.text = description
        }
    }
    
    func setGallery(_ images: [UIImage]) {
        DispatchQueue.main.async {
            self.images = images
        }
    }
    
    func setAddress(_ address: String) {
        DispatchQueue.main.async {
            self.addressLabel.text = address
        }
    }
    
    func setMap(lat: Float, lon: Float) {
        // Set visible region
        let latitude = CLLocationDegrees(lat)
        let longitude = CLLocationDegrees(lon)
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let radius = CLLocationDistance(1500)
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: radius,
                                        longitudinalMeters: radius)
        
        self.mapView.setRegion(region, animated: true)
        
        // Mark hotel coordinates on the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        self.mapView.addAnnotation(annotation)
    }
    
    func setPrice(_ price: String) {
        DispatchQueue.main.async {
            self.priceLabel.text = price
        }
    }
    
    func setNights(_ nights: String) {
        self.nightCountLabel.text = nights
    }
    
    func setMaxPeople(_ maxPeople: String) {
        self.peopleCountLabel.text = maxPeople
    }
    
    func setAmenities(_ amenities: [String]) {
        DispatchQueue.main.async {
            amenities.forEach { amenity in
                let label = UILabel()
                label.text = "- \(amenity)"
                label.font = label.font.withSize(15.0)
                self.amenitiesStackView.addArrangedSubview(label)
            }
        }
    }
    
}

extension PackageDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.imageView.image = self.images[indexPath.row]
        
        return cell
    }
}

extension PackageDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
}
