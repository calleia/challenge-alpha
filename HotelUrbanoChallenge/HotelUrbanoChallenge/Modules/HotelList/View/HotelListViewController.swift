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
    var suggestionsViewController: SuggestionsViewController!
    var httpClient: HttpClientProtocol!
    
    var presenter: HotelListPresenterProtocol? = nil
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hotels = [Hotel]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = "Hotéis"
        self.navigationItem.title = title
        self.navigationController?.tabBarItem.title = title
        
        let nib = UINib(nibName: "HotelCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: HotelCell.identifier)
        
        self.searchController.searchBar.placeholder = "Onde deseja se hospedar?"
    }
}

extension HotelListViewController: HotelListView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func showHotels(_ hotels: [Hotel]) {
        DispatchQueue.main.async {
            self.hotels = hotels
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showSuggestions(suggestions: [String]) {
        DispatchQueue.main.async {
            self.suggestionsViewController.suggestions = suggestions
            self.suggestionsViewController.tableView.reloadData()
        }
    }
}

extension HotelListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.hotels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: HotelCell.identifier, for: indexPath) as! HotelCell
        cell.nameLabel.text = self.hotels[indexPath.row].name
        cell.priceLabel.text = "R$ \(Int(self.hotels[indexPath.row].price.amountPerDay))"
        cell.freeCancellationLabel.isHidden = !self.hotels[indexPath.row].freeCancellation
        
        var address = self.hotels[indexPath.row].address.city ?? ""
        if !address.isEmpty {
            address.append(", ")
        }
        address.append(self.hotels[indexPath.row].address.state ?? "")
        cell.addressLabel.text = address
        
        for (index, starView) in cell.starStackView.arrangedSubviews.enumerated() {
            if index < self.hotels[indexPath.row].stars {
                starView.isHidden = false
            } else {
                starView.isHidden = true
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageString = self.hotels[indexPath.row].image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let imageUrl = URL(string: imageString) {
                
                self.httpClient.request(url: imageUrl) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            cell.imageView.image = UIImage(data: data)
                        }
                    case .failure(_):
                        break
                    }
                }
            }
        }
        
        return cell
    }
}

extension HotelListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hotel = self.hotels[indexPath.row]
        self.presenter?.showDetails(for: hotel)
    }
}

extension HotelListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width - 32.0, height: 0.30 * self.collectionView.bounds.height)
    }
}

extension HotelListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.presenter?.getSuggestions(for: searchBar.text!)
    }
}

extension HotelListViewController: UISearchControllerDelegate {}

extension HotelListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.presenter?.searchHotels(in: searchBar.text ?? "")
        self.suggestionsViewController.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
}

extension HotelListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = self.suggestionsViewController.suggestions[indexPath.row]
        self.searchController.searchBar.text = suggestion
        self.presenter?.searchHotels(in: suggestion)
        self.suggestionsViewController.dismiss(animated: true, completion: nil)
    }
}
