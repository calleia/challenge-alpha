//
//  HotelDetailsViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 16/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelDetailsViewController: UIViewController {
    
    var presenter: HotelDetailsPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\n\nVIEW LOADED\n\n")
        print(self.presenter)
    }
    
}

extension HotelDetailsViewController: HotelDetailsView {
    func setName(_ name: String) {
        // TODO
    }
    
    func setImage(_ image: UIImage) {
        // TODO
    }
    
    func setStars(_ stars: Int) {
        // TODO
    }
    
    func setFreeCancellation(_ freeCancellation: Bool) {
        // TODO
    }
    
    func setCity(_ city: String) {
        // TODO
    }
    
    func setState(_ state: String) {
        // TODO
    }
    
    func setPrice(_ price: Int) {
        // TODO
    }
}
