//
//  ProductsDetailVCTests.swift
//  GoustoProductsTests
//
//  Created by Iovanna Mishanina on 12/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import XCTest
@testable import GoustoProducts

class ProductsDetailVCTests: XCTestCase {
    private var productDetailVC: ProductDetailViewController!

    override func setUp() {
        productDetailVC = ProductDetailViewController()
    }

    func test_whenSetViewModelToProductDetails_updatesProductsFields() {
        productDetailVC.viewModel = testViewModel
        XCTAssertEqual(productDetailVC.title, testViewModel.title)
        XCTAssertEqual(productDetailVC.descriptionLabel.text, testViewModel.description)
        XCTAssertEqual(productDetailVC.priceLabel.text, testViewModel.price)
    }

    func test_whenImageUrlIsEmpty_then() {
        productDetailVC.viewModel = testViewModel
        XCTAssertNil(productDetailVC.imageView.image)
    }
}

let testViewModel = ProductDetailViewModel(title: "Balsajo Black Garlic Cloves",
                                           description: "What happens if you leave a premium garlic bulb in an oven for a few weeks to slow cook? You get this wonderful stuff! With a sweet, strong and balsamicky taste, it’s a seriously exciting ingredient to try out in your cooking.",
                                           price: "Price: 9.95",
                                           imageURL: URL(string: "https://production-media.gousto.co.uk/cms/product-image-landscape/Balsajo-BlackGarlic_17876-x200.jpg")!)


let testViewModelWithEmptyImageURL = ProductDetailViewModel(title: "Balsajo Black Garlic Cloves",
                                           description: "What happens if you leave a premium garlic bulb in an oven for a few weeks to slow cook? You get this wonderful stuff! With a sweet, strong and balsamicky taste, it’s a seriously exciting ingredient to try out in your cooking.",
                                           price: "Price: 9.95",
                                           imageURL: nil)

