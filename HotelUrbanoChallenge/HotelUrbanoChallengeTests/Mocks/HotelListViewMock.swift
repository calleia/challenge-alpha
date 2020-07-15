//
//  HotelListViewMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 24/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class HotelListViewMock: HotelListView {
    
    var showActivityIndicatorCallCount = 0
    var hideActivityIndicatorCallCount = 0
    
    var showHotelsCallCount = 0
    var lastHotelList = [Hotel]()
    
    var showErrorCallCount = 0
    var lastErrorMessage = ""
    
    var showSuggestionsCallCount = 0
    var lastSuggestions = [String]()
    
    func showActivityIndicator() {
        self.showActivityIndicatorCallCount += 1
    }
    
    func hideActivityIndicator() {
        self.hideActivityIndicatorCallCount += 1
    }
    
    func showHotels(_ hotels: [Hotel]) {
        self.lastHotelList = hotels
        self.showHotelsCallCount += 1
    }
    
    func showError(message: String) {
        self.lastErrorMessage = message
        self.showErrorCallCount += 1
    }
    
    func showSuggestions(suggestions: [String]) {
        self.lastSuggestions = suggestions
        self.showSuggestionsCallCount += 1
    }
    
}
