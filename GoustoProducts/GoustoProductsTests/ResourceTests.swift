//
//  ResourceTests.swift
//  GoustoProductsTests
//
//  Created by Iovanna Mishanina on 12/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import XCTest
@testable import GoustoProducts

class ResourceTests: XCTestCase {

    private var resource: Resource<Products>!

    private var testUrl: URL {
        get {
            let queryItems = [NSURLQueryItem(name: "image_sizes[]", value: "750")]
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.gousto.co.uk"
            components.path = "/products/v2.0/products"
            components.queryItems = queryItems as [URLQueryItem]
            return components.url!
        }
    }

    override func setUp() {
        resource = Resource(get: testUrl)
    }

    func testExample() {
        let expectedURL = URL(string: "https://api.gousto.co.uk/products/v2.0/products?image_sizes%5B%5D=750")!
        XCTAssertEqual(resource.urlRequest.url, expectedURL)
    }

}
