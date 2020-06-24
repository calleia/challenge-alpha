//
//  SearchHotelPresenterFactory.swift
//  Hotel Urbano Challenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SearchHotelPresenterFactory {
    static func make(wireframe: SearchHotelWireframeProtocol) -> SearchHotelPresenter {
        let presenter = SearchHotelPresenter(wireframe: wireframe)
        
        return presenter
    }
}
