//
//  HotelCell.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 13/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelCell: UICollectionViewCell {
    
    static let identifier = "HotelCellIdentifier"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var freeCancellationLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var starStackView: UIStackView!
    
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

extension HotelCell {
    private func initializeProperties() {
        self.nameLabel.text = nil
        self.addressLabel.text = nil
        self.priceLabel.text = nil
        self.freeCancellationLabel.isHidden = true
        self.imageView.image = nil
        
        self.starStackView.subviews.forEach { starImageView in
            starImageView.isHidden = true
        }
    }
    
    private func setupShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5.0
    }
}
