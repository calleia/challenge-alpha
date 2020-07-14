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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
