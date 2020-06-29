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
                // TODO: show the required hotel data
                let hotelNames = hotels.map { hotel in
                    hotel.name
                }
                
                self.view?.showHotels(hotelNames)
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
        case .invalidServiceResponse:
            return "O serviço retornou dados inválidos, por favor tente novamente."
        case .connection(_):
            return "Falha na conexão com o serviço, por favor tente novamente."
        case .service(let statusCode):
            return "Ocorreu uma falha no servidor (código: \(statusCode)). Por favor tente novamente."
        }
    }
}
