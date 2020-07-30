//
//  PackageListViewMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class PackageListViewMock: PackageListView {
    
    var showActivityIndicatorCallCount = 0
    var hideActivityIndicatorCallCount = 0
    
    var showPackagesCallCount = 0
    var lastPackageList = [Package]()
    
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
    
    func showPackages(_ packages: [Package]) {
        self.lastPackageList = packages
        self.showPackagesCallCount += 1
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
