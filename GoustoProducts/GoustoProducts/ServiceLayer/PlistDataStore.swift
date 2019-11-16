//
//  DataStoreProtocol.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

final class PlistDataStore: DataStoreProtocol, DataStoreUpdating {

    private(set) var products: [Product] {
        didSet {
            serialize(products, toFileAt: productPlist)
        }
    }

    weak var observer: DataStoreObserver!

    init() {
        //TODO: move disk access off the main thread
        products = deserializeFromFile(at: productPlist)
    }

    func update(products: [Product]) {
        self.products = products
        observer.productsDidUpdate(products: products)
    }
}
private func serialize<A: Codable>(_ entities: [A], toFileAt url:URL) {

    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(entities)
      try data.write(to: url)
    } catch {
      // Handle error
        
    }
}

private func deserializeFromFile<A: Codable>(at url:URL) -> [A] {
    let decoder = PropertyListDecoder()
    if let data = try? Data(contentsOf: url) {
        do {
            return try decoder.decode([A].self, from: data)
        } catch {
            return []
        }
    }
    return []
}

private let cachesDir = FileManager().urls(for: .cachesDirectory, in: .userDomainMask)[0]
private let productPlist = cachesDir.appendingPathComponent("products.plist")
