//
//  SearchHotelPresenter.swift
//  Hotel Urbano Challenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SearchHotelPresenter: SearchHotelPresenterProtocol {
    
    private var wireframe: SearchHotelWireframeProtocol
    
    weak var view: SearchHotelView? = nil
    
    init(wireframe: SearchHotelWireframeProtocol) {
        self.wireframe = wireframe
    }
}
