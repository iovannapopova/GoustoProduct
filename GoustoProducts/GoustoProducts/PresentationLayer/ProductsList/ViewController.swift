//
//  ViewController.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import UIKit


final class ViewController: UIViewController {

    let tableView: UITableView
    let tableViewDataSource: TableViewDataSource
    unowned let controller: UIDelegate

    var cellViewModels: [CellViewModel] = [] {
        didSet {
            tableViewDataSource.cellViewModels = cellViewModels
            tableView.reloadData()
        }
    }

    init(delegate: TableViewDelegate, controller: UIDelegate) {
        tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "CellID")
        tableViewDataSource = TableViewDataSource()
        tableView.delegate = delegate
        tableView.dataSource = tableViewDataSource
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controller.uiDidAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension ViewController: UI { }


