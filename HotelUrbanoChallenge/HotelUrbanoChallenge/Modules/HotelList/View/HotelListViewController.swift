//
//  HotelListViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelListViewController: UIViewController {
    
    var searchController: UISearchController!
    
    var presenter: HotelListPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchBar.placeholder = "Onde deseja se hospedar?"
    }
}

extension HotelListViewController: HotelListView {
    func showActivityIndicator() {
        // TODO: show activity indicator view
    }
    
    func hideActivityIndicator() {
        // TODO: hide activity indicator view
    }
    
    func showHotels(_ hotels: [String]) {
        // TODO: show hotel list
    }
    
    func showError(message: String) {
        // TODO: show error view
    }
}

extension HotelListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: filter results
    }
}

extension HotelListViewController: UISearchControllerDelegate {}

extension HotelListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
}
