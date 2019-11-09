//
//  Router.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import UIKit
import Foundation

protocol Routing: class {
    func showProductDetailViewController(with model: ProductDetailViewModel)
}

final class Router: Routing {
    let navigationController : UINavigationController
    let viewController: ViewController
    let tableViewDelegate: TableViewDelegate
    unowned let controller: Controller
    var detailViewController: ProductDetailViewController!

    init(controller: Controller) {
        tableViewDelegate = TableViewDelegate(selectionController: controller)
        viewController = ViewController(delegate: tableViewDelegate, controller: controller, searchController: controller)
        viewController.title = "Gousto"
        navigationController = UINavigationController(rootViewController: viewController)
        self.controller = controller

        controller.productsUI = viewController
        controller.router = self
    }

    func showProductDetailViewController(with model: ProductDetailViewModel) {
        detailViewController = ProductDetailViewController()
        detailViewController.viewModel = model
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

