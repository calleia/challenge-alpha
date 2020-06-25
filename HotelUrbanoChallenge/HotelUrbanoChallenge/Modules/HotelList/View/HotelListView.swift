//
//  HotelListView.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

protocol HotelListView: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showHotels(_ hotels: [String])
    func showError(message: String)
}
