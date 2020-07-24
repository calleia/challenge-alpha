//
//  PackageListViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 21/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class PackageListViewController: UIViewController {
    
    var searchController: UISearchController!
    var suggestionsViewController: SuggestionsViewController!
    
    var presenter: PackageListPresenterProtocol? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var packages = [Package]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Pacotes"
        
        let nib = UINib(nibName: "PackageCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: PackageCell.identifier)
        
        self.searchController.searchBar.placeholder = "Para onde deseja viajar?"
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
        DispatchQueue.main.async {
            self.packages = packages
        }
    }
    
    func showError(message: String) {
        // TODO: show error
    }
    
    func showSuggestions(suggestions: [String]) {
        DispatchQueue.main.async {
            self.suggestionsViewController.suggestions = suggestions
            self.suggestionsViewController.tableView.reloadData()
        }
    }
    
}

extension PackageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: PackageCell.identifier, for: indexPath) as! PackageCell
        
        cell.nameLabel.text = self.packages[indexPath.row].name
        cell.priceLabel.text = "R$ \(Int(self.packages[indexPath.row].price.amountPerDay))"
        
        let nightCountDescriptor = self.packages[indexPath.row].quantityDescriptors.nights > 1 ? "diárias" : "diária"
        cell.nightCountLabel.text = "\(self.packages[indexPath.row].quantityDescriptors.nights) \(nightCountDescriptor)"
        
        let peopleCountDescriptor = self.packages[indexPath.row].quantityDescriptors.maxPeople > 1 ? "pessoas" : "pessoa"
        cell.peopleCountLabel.text = "\(self.packages[indexPath.row].quantityDescriptors.maxPeople) \(peopleCountDescriptor)"
        
        var address = self.packages[indexPath.row].address.city ?? ""
        if !address.isEmpty {
            address.append(", ")
        }
        address.append(self.packages[indexPath.row].address.state ?? "")
        cell.addressLabel.text = address
        
        // TODO: set image
        
        return cell
    }
}

extension PackageListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = self.packages[indexPath.row]
        self.presenter?.showDetails(for: package)
    }
}

extension PackageListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width - 32.0, height: 0.30 * self.collectionView.bounds.height)
    }
}

extension PackageListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.presenter?.getSuggestions(for: searchBar.text!)
    }
}

extension PackageListViewController: UISearchControllerDelegate {}

extension PackageListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.presenter?.searchPackages(in: searchBar.text ?? "")
        self.suggestionsViewController.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
}

extension PackageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = self.suggestionsViewController.suggestions[indexPath.row]
        self.searchController.searchBar.text = suggestion
        self.presenter?.searchPackages(in: suggestion)
        self.suggestionsViewController.dismiss(animated: true, completion: nil)
    }
}
