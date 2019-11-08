//
//  NetwotkClient.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

final class NetworkClient {

    private unowned let dataStore: DataStoreUpdating

    init(dataStore: DataStoreUpdating) {
        self.dataStore = dataStore
    }
    
    func refresh() {
            URLSession.shared.load(products) { products in
            guard let products = products else {
                return
            }
            DispatchQueue.main.async {
                self.dataStore.update(products: products.data)
            }
        }
    }
}
