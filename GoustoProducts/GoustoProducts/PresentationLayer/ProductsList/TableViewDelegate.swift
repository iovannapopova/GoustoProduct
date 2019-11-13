//
//  TableViewDelegate.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import UIKit

final class TableViewDelegate : NSObject, UITableViewDelegate {
    private unowned let selectionController: TableSelection

    init(selectionController: TableSelection) {
        self.selectionController = selectionController
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionController.onRowSelected(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }

}
