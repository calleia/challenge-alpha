//
//  HotelListPresenter.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 23/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class HotelListPresenter: HotelListPresenterProtocol {
    
    private var searchHotelsInteractor: SearchHotelsInteractorProtocol
    private var wireframe: HotelListWireframeProtocol
    
    weak var view: HotelListView? = nil
    
    init(searchHotelsInteractor: SearchHotelsInteractorProtocol,
         wireframe: HotelListWireframeProtocol) {
        self.searchHotelsInteractor = searchHotelsInteractor
        self.wireframe = wireframe
    }
    
    func searchHotels(in location: String) {
        self.view?.showActivityIndicator()
        
        self.searchHotelsInteractor.search(in: location) { result in
            switch result {
            case .success(let hotels):
                self.view?.showHotels(hotels)
            case .failure(let error):
                let message = self.makeErrorMessage(for: error)
                self.view?.showError(message: message)
            }
            
            self.view?.hideActivityIndicator()
        }
    }
}

extension HotelListPresenter {
    private func makeErrorMessage(for error: HotelSearchError) -> String {
        switch error {
        case .requestTimeout:
            return "Request timeout, por favor tente novamente."
        }
    }
}
