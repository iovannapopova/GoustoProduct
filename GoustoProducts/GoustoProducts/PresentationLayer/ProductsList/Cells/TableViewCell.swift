//
//  TableViewCell.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var viewModel: CellViewModel! {
        didSet {
            if oldValue != viewModel {
                update()
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.detailTextLabel?.textColor = .gray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.price
        imageView?.image = nil
        guard let imageURL = viewModel.imageURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: imageURL) { (responseData, response, _) in
            guard let data = responseData else {
                return
            }
            DispatchQueue.main.async {
                guard response?.url == self.viewModel.imageURL else {
                    return
                }
                self.imageView?.image = UIImage(data: data, scale: UIScreen.main.scale)
                self.setNeedsLayout()

            }
        }
        task.resume()
    }
}
