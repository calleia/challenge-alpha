//
//  SuggestionsViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class SuggestionsViewController: UITableViewController {
    
    var presenter: SuggestionsPresenterProtocol? = nil
    
    var suggestions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SuggestionCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SuggestionCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.suggestions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionCell.identifier, for: indexPath)
        
        cell.textLabel?.text = self.suggestions[indexPath.row]
        
        return cell
    }
    
}

extension SuggestionsViewController: SuggestionsView {}
