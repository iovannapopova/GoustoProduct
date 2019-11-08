//
//  DataStore.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

protocol DataStoreObserver: class {
    func productsDidUpdate(products: [Product])
}

protocol DataStoreProtocol: class {
    var products: [Product] { get }
}

protocol DataStoreUpdating: class {
    func update(products: [Product])
}
