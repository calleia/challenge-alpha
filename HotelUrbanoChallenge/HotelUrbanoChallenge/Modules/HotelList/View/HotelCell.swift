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
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initializeProperties()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.initializeProperties()
    }

}

extension HotelCell {
    private func initializeProperties() {
        self.nameLabel.text = nil
        self.imageView.image = nil
    }
}
