//
//  ProductsScreen.swift
//  GoustoProductsUITests
//
//  Created by Iovanna Mishanina on 14/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import XCTest
@testable import GoustoProducts

class ProductsScreen: XCTestCase {

    static let app = XCUIApplication()
    static let cells = app.cells
    let tablesQuery = app.tables

    override func setUp() {
        continueAfterFailure = false
        ProductsScreen.app.launch()
    }

    func test_whenAppIsLaunched_thenScreenElementsAreShown() {
        XCTAssert(ProductsScreen.app.staticTexts["Gousto"].exists, "Gousto text label is shown")
        XCTAssert(ProductsScreen.app.otherElements[AccessibilityIdentifier.searchBar].exists, "Search Bar is shown")
        XCTAssert(ProductsScreen.cells.firstMatch.exists, "At least one cell is shown")
    }

    func test_whenScrollTableView_thenFolowingCellAreShown() {
        tablesQuery.firstMatch.swipeUp()
        XCTAssert(ProductsScreen.cells.firstMatch.exists, "The following cell is shown")
    }

    func test_whenCellIsTapped_thenProductDetailsScreenIsShown() {
        let cell = ProductsScreen.cells.firstMatch
        cell.tap()

        XCTAssert(ProductsScreen.app.staticTexts[AccessibilityIdentifier.productDetailDescription].exists)
        XCTAssert(ProductsScreen.app.images[AccessibilityIdentifier.productDetailImage].exists)
        XCTAssert(ProductsScreen.app.staticTexts[AccessibilityIdentifier.productDetailPrice].exists)
    }
}
