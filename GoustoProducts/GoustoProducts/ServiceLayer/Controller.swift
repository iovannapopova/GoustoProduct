//
//  Controller.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

protocol UI: class {
    var cellViewModels: [CellViewModel] { get set }
}

protocol UIDelegate: class {
    func uiDidAppear()
}

final class Controller {
    fileprivate unowned let store: DataStoreProtocol
    fileprivate var products: [Product] { return store.products }


    weak var productsUI: UI!
    weak var router: Routing!

    init(store: DataStoreProtocol) {
        self.store = store
    }

    fileprivate func updateProductsUI() {
        productsUI.cellViewModels = products.map {  CellViewModel(title: $0.title, detail: "") }
    }
}

extension Controller: UIDelegate {
    func uiDidAppear() {
        updateProductsUI()
    }
}

extension Controller: DataStoreObserver {
    func productsDidUpdate(products: [Product]) {
        updateProductsUI()
    }
}
