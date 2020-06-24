//
//  HotelListPresenter.swift
//  Hotel Urbano Challenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelListPresenter: HotelListPresenterProtocol {
    
    private var wireframe: HotelListWireframeProtocol
    
    weak var view: HotelListView? = nil
    
    init(wireframe: HotelListWireframeProtocol) {
        self.wireframe = wireframe
    }
}
