//
//  SuggestionsWireframe.swift
//  HotelUrbanoChallenge
//
//  Created by Fellipe Calleia on 12/08/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import UIKit

final class SuggestionsWireframe: SuggestionsWireframeProtocol {
    
    func presentSuggestions(for location: String, in navigationController: UINavigationController) {
        let viewController = SuggestionsViewControllerFactory.make()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
