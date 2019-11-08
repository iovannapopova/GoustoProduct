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
    
}

final class Router: Routing {
    let navigationController : UINavigationController
    let viewController: ViewController
    let tableViewDelegate: TableViewDelegate
    unowned let controller: Controller


    init(controller: Controller) {
        tableViewDelegate = TableViewDelegate()
        viewController = ViewController(delegate: tableViewDelegate, controller: controller)
        viewController.title = "Gousto"
        navigationController = UINavigationController(rootViewController: viewController)
        self.controller = controller

        controller.productsUI = viewController
        controller.router = self
    }
}

