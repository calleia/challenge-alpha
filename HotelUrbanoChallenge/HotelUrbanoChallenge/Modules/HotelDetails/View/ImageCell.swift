//
//  ImageCell.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    static let identifier = "ImageCellIdentifier"
    
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


extension ImageCell {
    private func initializeProperties() {
        self.imageView.image = nil
    }
}
