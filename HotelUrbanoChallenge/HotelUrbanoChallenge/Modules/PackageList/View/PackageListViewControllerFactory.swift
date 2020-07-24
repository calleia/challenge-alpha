//
//  PackageListViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 21/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class PackageListViewControllerFactory {
    static func make() -> PackageListViewController {
        let viewController = PackageListViewController()
        self.setupPresenter(viewController)
        self.setupSearchController(viewController)
        self.setupHttpClient(viewController)
        
        return viewController
    }
}

extension PackageListViewControllerFactory {
    private static func setupPresenter(_ viewController: PackageListViewController) {
        let wireframe = PackageListWireframe()
        wireframe.viewController = viewController
        
        let presenter = PackageListPresenterFactory.make(wireframe: wireframe)
        presenter.view = viewController
        
        viewController.presenter = presenter
    }
    
    private static func setupSearchController(_ viewController: PackageListViewController) {
        let suggestionsViewController = SuggestionsViewControllerFactory.make()
        suggestionsViewController.tableView.delegate = viewController
        
        let searchController = UISearchController(searchResultsController: suggestionsViewController)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.delegate = viewController
        searchController.searchResultsUpdater = viewController
        searchController.searchBar.delegate = viewController
        viewController.searchController = searchController
        viewController.suggestionsViewController = suggestionsViewController
        
        // Hide main view controller when showing search results
        viewController.definesPresentationContext = true
        
        // Add the search bar to the navigation bar.
        viewController.navigationItem.searchController = searchController
        
        // Always show search bar.
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private static func setupHttpClient(_ viewController: PackageListViewController) {
        let httpClient = HttpClient()
        viewController.httpClient = httpClient
    }
}
