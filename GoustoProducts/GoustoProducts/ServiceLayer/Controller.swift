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

protocol TableSelection: class {
    func onRowSelected(at indexPath: IndexPath)
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
        productsUI.cellViewModels = products.map { product in
            let images = product.images
            var url: URL?
            if let imageSources = images["750"] as? ImageSources {
                url = URL(string: imageSources.url)!
            }
            return CellViewModel(title: product.title,
                          price: product.listPrice,
                          imageURL: url)

        }
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

extension Controller: TableSelection {
    func onRowSelected(at indexPath: IndexPath) {
        let product = products[indexPath.row]
        let images = product.images
        var url: URL?
        if let imageSources = images["750"] as? ImageSources {
            url = URL(string: imageSources.url)!
        }
        let vm = ProductDetailViewModel(title: product.title,
                                        description: product.title,
                                        price: "Price: ",// + product.listPrice.stringValue,
                                        imageURL: url)
        router.showProductDetailViewController(with: vm)
    }
}
