//
//  PackageListPresenter.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class PackageListPresenter: PackageListPresenterProtocol {
    
    private var searchPackagesInteractor: SearchPackagesInteractorProtocol
    private var getSuggestionsInteractor: GetSuggestionsInteractorProtocol
    private var wireframe: PackageListWireframeProtocol
    
    weak var view: PackageListView? = nil
    
    init(searchPackagesInteractor: SearchPackagesInteractorProtocol,
         getSuggestionsInteractor: GetSuggestionsInteractorProtocol,
         wireframe: PackageListWireframeProtocol) {
        self.searchPackagesInteractor = searchPackagesInteractor
        self.getSuggestionsInteractor = getSuggestionsInteractor
        self.wireframe = wireframe
    }
    
    func searchPackages(in location: String) {
        self.view?.showActivityIndicator()
        
        self.searchPackagesInteractor.search(in: location) { result in
            switch result {
            case .success(let packages):
                self.view?.showPackages(packages)
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
    
    func showDetails(for package: Package) {
        self.wireframe.presentDetails(for: package)
    }
}

extension PackageListPresenter {
    private func makeErrorMessage(for error: PackageSearchError) -> String {
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
