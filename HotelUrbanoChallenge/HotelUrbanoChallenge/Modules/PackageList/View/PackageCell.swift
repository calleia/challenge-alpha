//
//  PackageCell.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

class PackageCell: UICollectionViewCell {
    
    static let identifier = "PackageCellIdentifier"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var nightCountLabel: UILabel!
    
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initializeProperties()
        self.setupShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.initializeProperties()
    }
    
}

extension PackageCell {
    private func initializeProperties() {
        self.nameLabel.text = nil
        self.addressLabel.text = nil
        self.nightCountLabel.text = nil
        self.peopleCountLabel.text = nil
        self.priceLabel.text = nil
        self.imageView.image = nil
    }
    
    private func setupShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5.0
    }
}
