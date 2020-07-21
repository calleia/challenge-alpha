//
//  PackageListPresenterTests.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 20/07/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import XCTest

@testable import HotelUrbanoChallenge

final class PackageListPresenterTests: XCTestCase {
    
    private var packageListViewMock: PackageListViewMock!
    private var packageListWireframeMock: PackageListWireframeMock!
    private var searchPackagesInteractorMock: SearchPackagesInteractorMock!
    private var getSuggestionsInteractorMock: GetSuggestionsInteractorMock!
    private var presenter: PackageListPresenter!
    
    override func setUpWithError() throws {
        self.packageListViewMock = PackageListViewMock()
        self.packageListWireframeMock = PackageListWireframeMock()
        self.searchPackagesInteractorMock = SearchPackagesInteractorMock()
        self.getSuggestionsInteractorMock = GetSuggestionsInteractorMock()
        self.presenter = PackageListPresenter(searchPackagesInteractor: self.searchPackagesInteractorMock,
                                              getSuggestionsInteractor: self.getSuggestionsInteractorMock,
                                              wireframe: self.packageListWireframeMock)
        self.presenter.view = self.packageListViewMock
    }
    
    override func tearDownWithError() throws {
        self.packageListViewMock = nil
        self.packageListWireframeMock = nil
        self.searchPackagesInteractorMock = nil
        self.getSuggestionsInteractorMock = nil
        self.presenter = nil
    }
    
    func testInitialValues() throws {
        XCTAssertEqual(self.searchPackagesInteractorMock.callCount, 0)
        XCTAssertEqual(self.searchPackagesInteractorMock.lastLocation, "")
        
        XCTAssertEqual(self.packageListViewMock.showActivityIndicatorCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.hideActivityIndicatorCallCount, 0)
        
        XCTAssertEqual(self.packageListViewMock.showPackagesCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.lastPackageList, [])
        
        XCTAssertEqual(self.packageListViewMock.showErrorCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.lastErrorMessage, "")
        
        XCTAssertEqual(self.getSuggestionsInteractorMock.callCount, 0)
        XCTAssertEqual(self.getSuggestionsInteractorMock.lastLocation, "")
        
        XCTAssertEqual(self.packageListWireframeMock.presentDetailsCallCount, 0)
        XCTAssertEqual(self.packageListWireframeMock.lastPresentedDetails, nil)
    }
    
    func testSearchPackages() throws {
        self.presenter.searchPackages(in: "Location Value")
        
        XCTAssertEqual(self.searchPackagesInteractorMock.callCount, 1)
        XCTAssertEqual(self.searchPackagesInteractorMock.lastLocation, "Location Value")
        
        XCTAssertEqual(self.packageListViewMock.showActivityIndicatorCallCount, 1)
        XCTAssertEqual(self.packageListViewMock.hideActivityIndicatorCallCount, 1)
    }
    
    func testShowPackages() throws {
        let package = self.makePackageMock()
        self.searchPackagesInteractorMock.packages = [package]
        
        self.presenter.searchPackages(in: "Location Value")
        
        XCTAssertEqual(self.packageListViewMock.showPackagesCallCount, 1)
        XCTAssertEqual(self.packageListViewMock.lastPackageList, [package])
        
        XCTAssertEqual(self.packageListViewMock.showErrorCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.lastErrorMessage, "")
    }
    
    func testShowResponseError() throws {
        self.searchPackagesInteractorMock.error = .invalidServiceResponse
        
        self.presenter.searchPackages(in: "Location Value")
        
        XCTAssertEqual(self.packageListViewMock.showPackagesCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.lastPackageList, [])
        
        XCTAssertEqual(self.packageListViewMock.showErrorCallCount, 1)
        XCTAssertEqual(self.packageListViewMock.lastErrorMessage, "O serviço retornou dados inválidos, por favor tente novamente.")
    }
    
    func testShowConnectionError() throws {
        self.searchPackagesInteractorMock.error = .connection("Falha na conexão")
        
        self.presenter.searchPackages(in: "Location Value")
        
        XCTAssertEqual(self.packageListViewMock.showPackagesCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.lastPackageList, [])
        
        XCTAssertEqual(self.packageListViewMock.showErrorCallCount, 1)
        XCTAssertEqual(self.packageListViewMock.lastErrorMessage, "Falha na conexão com o serviço, por favor tente novamente.")
    }
    
    func testShowServiceError() throws {
        self.searchPackagesInteractorMock.error = .service(500)
        
        self.presenter.searchPackages(in: "Location Value")
        
        XCTAssertEqual(self.packageListViewMock.showPackagesCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.lastPackageList, [])
        
        XCTAssertEqual(self.packageListViewMock.showErrorCallCount, 1)
        XCTAssertEqual(self.packageListViewMock.lastErrorMessage, "Ocorreu uma falha no servidor (código: 500). Por favor tente novamente.")
    }
    
    func testRequestSuggestions() throws {
        self.presenter.getSuggestions(for: "Location Value")
        
        XCTAssertEqual(self.getSuggestionsInteractorMock.callCount, 1)
        XCTAssertEqual(self.getSuggestionsInteractorMock.lastLocation, "Location Value")
    }
    
    func testShowSuggestions() throws {
        let suggestionMock = Suggestion(value: "Suggestion Value", country: "", state: "", city: "", filter: "")
        self.getSuggestionsInteractorMock.suggestions = [suggestionMock]
        
        self.presenter.getSuggestions(for: "Location Value")
        
        XCTAssertEqual(self.packageListViewMock.showSuggestionsCallCount, 1)
        XCTAssertEqual(self.packageListViewMock.lastSuggestions, ["Suggestion Value"])
    }
    
    func testSuggestionsServiceError() throws {
        self.getSuggestionsInteractorMock.error = .invalidServiceResponse
        
        self.presenter.getSuggestions(for: "Location Value")
        
        XCTAssertEqual(self.packageListViewMock.showSuggestionsCallCount, 0)
        XCTAssertEqual(self.packageListViewMock.lastSuggestions, [])
    }
    
    func testPresentPackageDetails() throws {
        let package = self.makePackageMock()
        self.presenter.showDetails(for: package)
        
        XCTAssertEqual(self.packageListWireframeMock.presentDetailsCallCount, 1)
        XCTAssertEqual(self.packageListWireframeMock.lastPresentedDetails, package)
    }
    
}

extension PackageListPresenterTests {
    
    private func makePackageMock() -> Package {
        let geoLocation = GeoLocation(lat: 12.34, lon: 56.78)
        let address = Address(city: "Address City", state: "Address State", geoLocation: geoLocation)
        let price = Price(amountPerDay: 42.0)
        let amenity = Amenity(name: "Amenity Name", category: "Amenity Category")
        let package = Package(id: "Package ID",
                              name: "Package Name",
                              smallDescription: "Package Small Description",
                              description: "Package Description",
                              gallery: [],
                              address: address,
                              price: price,
                              amenities: [amenity])
        
        return package
    }
    
}
