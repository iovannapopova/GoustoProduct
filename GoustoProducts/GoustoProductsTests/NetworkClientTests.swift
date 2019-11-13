//
//  NetworkClientTests.swift
//  GoustoProductsTests
//
//  Created by Iovanna Mishanina on 12/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import XCTest
@testable import GoustoProducts

class NetworkClientTests: XCTestCase {

    private var networkClient: NetworkClient!

    override func setUp() {
        networkClient = NetworkClient(dataStore: PlistDataStore())
    }

    func testExample() {
        networkClient.refresh()
    }

}
