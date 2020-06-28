//
//  HttpClientMock.swift
//  HotelUrbanoChallengeTests
//
//  Created by Fellipe Calleia on 28/06/20.
//  Copyright © 2020 Fellipe Calleia. All rights reserved.
//

import Foundation

@testable import HotelUrbanoChallenge

final class HttpClientMock: HttpClientProtocol {
    static func request(url: URL, completion: @escaping (Result<String, HttpRequestError>) -> Void) {
    }
}
