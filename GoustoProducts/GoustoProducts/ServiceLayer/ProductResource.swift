//
//  ProductResource.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

private var url: URL {
    get {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.gousto.co.uk"
        components.path = "/products/v2.0/products"
        return components.url!
    }
}

let products = Resource<Products>(get: url)


