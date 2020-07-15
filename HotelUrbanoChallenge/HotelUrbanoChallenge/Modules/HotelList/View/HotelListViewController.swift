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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hotels = [Hotel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "HotelCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: HotelCell.identifier)
        
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
    
    func showHotels(_ hotels: [Hotel]) {
        DispatchQueue.main.async {
            self.hotels = hotels
            self.collectionView.reloadData()
        }
    }
    
    func showError(message: String) {
        // TODO: show error view
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
        cell.addressLabel.text = "\(self.hotels[indexPath.row].address.city), \(self.hotels[indexPath.row].address.state)"
        cell.priceLabel.text = "R$ \(Int(self.hotels[indexPath.row].price.amountPerDay))"
        
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

extension HotelListViewController: UICollectionViewDelegate {}

extension HotelListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: 0.30 * self.collectionView.bounds.height)
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
