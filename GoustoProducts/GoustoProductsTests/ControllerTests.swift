//
//  ControllerTests.swift
//  GoustoProductsTests
//
//  Created by Iovanna Mishanina on 12/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import XCTest
@testable import GoustoProducts

final class FakeDataStore: DataStoreProtocol {
    var products: [Product] = []
}

final class UISpy: UI {
    var cellViewModels: [CellViewModel] = []
}

final class RoutingSpy: Routing {
    var showProductDetailWasCalledWithModel: ProductDetailViewModel? = nil

    func showProductDetailViewController(with model: ProductDetailViewModel) {
        showProductDetailWasCalledWithModel = model
    }
}

class GoustoProducts: XCTestCase {

    private let dataStore = FakeDataStore()
    private let productsUI: UISpy = UISpy()
    private let router: RoutingSpy = RoutingSpy()
    private var controller: Controller!

    override func setUp() {
        controller = Controller(store: dataStore)
        controller.productsUI = productsUI
        controller.router = router

        dataStore.products = testProducts
    }


    func test_whenUIDidAppear_updatesUIWithViewModels() {
        controller.uiDidAppear()

        let expectedViewModel = [CellViewModel(title: "Balsajo Black Garlic Cloves",
                                               price: "Price: 9.95",
                                               imageURL: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg")!),
                                 CellViewModel(title: "Sancerre Blanc",
                                               price: "Price: 7.95",
                                               imageURL: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg")!)
        ]
        XCTAssertEqual(productsUI.cellViewModels, expectedViewModel)
    }

    func test_whenProductRowSelected_showsProductDetailVCWithViewModel() {
        controller.onRowSelected(at: IndexPath(row: 0, section: 0))

        let expectedVM = ProductDetailViewModel(title: "Balsajo Black Garlic Cloves",
                                                        description: "What happens if you leave a premium garlic bulb in an oven for a few weeks to slow cook? You get this wonderful stuff! With a sweet, strong and balsamicky taste, it’s a seriously exciting ingredient to try out in your cooking.",
                                                        price: "Price: 9.95",
                                                        imageURL: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg")!)
        XCTAssertEqual(router.showProductDetailWasCalledWithModel, expectedVM)
    }

    func test_whenProductsAreUpdates_updatesProductUI() {
        controller.productsDidUpdate(products: testProducts)

        let expectedViewModel = [CellViewModel(title: "Balsajo Black Garlic Cloves",
                                               price: "Price: 9.95",
                                               imageURL: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg")!),
                                 CellViewModel(title: "Sancerre Blanc",
                                               price: "Price: 7.95",
                                               imageURL: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg")!)]
        XCTAssertEqual(productsUI.cellViewModels, expectedViewModel)
    }

    func test_whenSearchResultsUpdated_updatesUIWithResults() {
        controller.updateSearchResults(for: "Balsajo")

        let expectedViewModel = [CellViewModel(title: "Balsajo Black Garlic Cloves",
                                               price: "Price: 9.95",
                                               imageURL: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg")!)]
        XCTAssertEqual(productsUI.cellViewModels, expectedViewModel)
    }
}

private let testProducts = [
    Product(title: "Balsajo Black Garlic Cloves",
            description: "What happens if you leave a premium garlic bulb in an oven for a few weeks to slow cook? You get this wonderful stuff! With a sweet, strong and balsamicky taste, it’s a seriously exciting ingredient to try out in your cooking.",
            listPrice: "9.95",
            images: ["750" : ImageSources(src: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg",
                                          url: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg",
                                          width: 750)]),
    Product(title: "Sancerre Blanc",
            description: "Intriguing notes of vanilla and chocolate make this fruity, full-bodied wine unique. With a long, pleasant finish and woody aroma supporting it, this characterful wine is a good match with beef dishes. ABV 14%.",
            listPrice: "7.95",
            images: ["750" : ImageSources(src: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg",
                                          url: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg",
                                          width: 750)])
]
