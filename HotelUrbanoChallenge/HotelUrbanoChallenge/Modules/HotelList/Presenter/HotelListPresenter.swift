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
    private var getSuggestionsInteractor: GetSuggestionsInteractorProtocol
    private var wireframe: HotelListWireframeProtocol
    
    weak var view: HotelListView? = nil
    
    init(searchHotelsInteractor: SearchHotelsInteractorProtocol,
         getSuggestionsInteractor: GetSuggestionsInteractorProtocol,
         wireframe: HotelListWireframeProtocol) {
        self.searchHotelsInteractor = searchHotelsInteractor
        self.getSuggestionsInteractor = getSuggestionsInteractor
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
    
    func getSuggestions(for location: String) {
        self.getSuggestionsInteractor.suggestions(for: location) { result in
            switch result {
            case .success(let suggestions):
                let suggestionValues = suggestions.map { suggestion in
                    suggestion.value
                }
                
                self.view?.showSuggestions(suggestions: suggestionValues)
            case .failure(_):
                break
            }
        }
    }
    
    func showDetails(for hotel: Hotel) {
        self.wireframe.presentDetails(for: hotel)
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
