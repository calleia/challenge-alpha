//
//  PackageListView.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

protocol PackageListView: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showPackages(_ packages: [Package])
    func showError(message: String)
    func showSuggestions(suggestions: [String])
}
