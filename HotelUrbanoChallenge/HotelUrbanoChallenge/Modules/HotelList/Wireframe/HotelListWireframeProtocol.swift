//
//  HotelListWireframeProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

protocol HotelListWireframeProtocol {
    func present(in window: UIWindow)
    func presentDetails(for hotel: Hotel)
}
