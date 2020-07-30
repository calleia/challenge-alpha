//
//  PackageListPresenterProtocol.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

protocol PackageListPresenterProtocol {
    func searchPackages(in location: String)
    func getSuggestions(for location: String)
    func showDetails(for package: Package)
}
