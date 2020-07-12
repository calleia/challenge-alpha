//
//  SuggestionsViewControllerFactory.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

final class SuggestionsViewControllerFactory {
    static func make() -> SuggestionsViewController {
        let viewController = SuggestionsViewController()
        self.setupPresenter(viewController)
        
        return viewController
    }
}

extension SuggestionsViewControllerFactory {
    private static func setupPresenter(_ viewController: SuggestionsViewController) {
        let presenter = SuggestionsPresenterFactory.make()
        presenter.view = viewController
        
        viewController.presenter = presenter
    }
}
