//
//  PackageListViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 21/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class PackageListViewController: UIViewController {
    
    var presenter: PackageListPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Pacotes"
    }
    
}

extension PackageListViewController: PackageListView {
    
    func showActivityIndicator() {
        // TODO: show activity indicator
    }
    
    func hideActivityIndicator() {
        // TODO: hide activity indicator
    }
    
    func showPackages(_ packages: [Package]) {
        // TODO: show packages
    }
    
    func showError(message: String) {
        // TODO: show error
    }
    
    func showSuggestions(suggestions: [String]) {
        // TODO: show suggestions
    }
    
}
