//
//  HotelListViewController.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class HotelListViewController: UIViewController {
    
    var presenter: HotelListPresenterProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension HotelListViewController: HotelListView {}
