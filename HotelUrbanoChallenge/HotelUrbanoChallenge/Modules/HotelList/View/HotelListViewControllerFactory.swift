//
//  HotelListViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelListViewControllerFactory {
    static func make(wireframe: HotelListWireframeProtocol) -> HotelListViewController {
        let viewController = HotelListViewController()
        self.setupPresenter(viewController, wireframe: wireframe)
        self.setupSearchController(viewController)
        
        return viewController
    }
}

extension HotelListViewControllerFactory {
    private static func setupPresenter(_ viewController: HotelListViewController, wireframe: HotelListWireframeProtocol) {
        let presenter = HotelListPresenterFactory.make(wireframe: wireframe)
        presenter.view = viewController
        
        viewController.presenter = presenter
    }
    
    private static func setupSearchController(_ viewController: HotelListViewController) {
        let suggestionsViewController = SuggestionsViewController()
        let searchController = UISearchController(searchResultsController: suggestionsViewController)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.delegate = viewController
        searchController.searchResultsUpdater = viewController
        searchController.searchBar.delegate = viewController
        viewController.searchController = searchController
        
        // Hide main view controller when showing search results
        viewController.definesPresentationContext = true
        
        // Add the search bar to the navigation bar.
        viewController.navigationItem.searchController = searchController
        
        // Always show search bar.
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
