//
//  SearchHotelViewController.swift
//  Hotel Urbano Challenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class SearchHotelViewController: UIViewController {
    
    var presenter: SearchHotelPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension SearchHotelViewController: SearchHotelView {}
