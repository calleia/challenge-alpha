//
//  HotelListWireframe.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelListWireframe: HotelListWireframeProtocol {
    
    private var hotelDetailsWireframe = HotelDetailsWireframe()
    
    weak var viewController: HotelListViewController? = nil
    
    func presentDetails(for hotel: Hotel) {
        guard let navigationController = self.viewController?.navigationController else {
            return
        }
        
        self.hotelDetailsWireframe.present(hotel: hotel, in: navigationController)
    }
}
