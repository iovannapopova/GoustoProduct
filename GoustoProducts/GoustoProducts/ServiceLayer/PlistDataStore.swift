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
private func serialize<A>(_ entities: [A], toFileAt url:URL) {
    (entities as NSArray).write(to: url, atomically: true)
}

private func deserializeFromFile<A>(at url:URL) -> [A] {
    return (NSArray(contentsOf: url) ?? []).compactMap {
        $0 as? A
    }
}

private let cachesDir = FileManager().urls(for: .cachesDirectory, in: .userDomainMask)[0]
private let productPlist = cachesDir.appendingPathComponent("products.plist")
