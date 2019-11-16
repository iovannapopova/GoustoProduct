//
//  TableViewCell.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import UIKit
import CoreGraphics

let templateColor = UIColor(red: 255.0/255.0, green: 0.0, blue: 50.0/255.0, alpha: 1.0)

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
        self.textLabel?.textColor = templateColor
        self.textLabel?.numberOfLines = 0
        self.textLabel?.accessibilityIdentifier = AccessibilityIdentifier.producrTitle
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.price
        imageView?.sizeToFit()
        imageView?.image = nil
        guard let imageURL = viewModel.imageURL else {let image = UIImage(named: "noimage")!
            self.imageView?.image = image.imageByCroppingImage(toTargetSize: CGSize(width: 88.0, height: 88.0))

            return
        }
        let task = URLSession.shared.dataTask(with: imageURL) { (responseData, response, _) in
            guard let data = responseData else {
                let image = UIImage(named: "noimage")!
                self.imageView?.image = image.imageByCroppingImage(toTargetSize: CGSize(width: 88.0, height: 88.0))

                return
            }
            DispatchQueue.main.async {
                guard response?.url == self.viewModel.imageURL else {
                    let image = UIImage(named: "noimage")!
                    self.imageView?.image = image.imageByCroppingImage(toTargetSize: CGSize(width: 88.0, height: 88.0))

                    return
                }
                let image = UIImage(data: data)!
                //image.resize(toTargetSize: CGSize(width: 88.0, height: 88.0))
                self.imageView?.image = image.imageByCroppingImage(toTargetSize: CGSize(width: 100.0, height: 100.0)) //image.resize(toTargetSize: CGSize(width: 88.0, height: 88.0))
                self.setNeedsLayout()

            }
        }
        task.resume()
    }

}

extension UIImage {
     func imageByCroppingImage(toTargetSize targetSize: CGSize) -> UIImage {
        let width = CGFloat(cgImage!.width)
        let height = CGFloat(cgImage!.height)
        //let scale = min(targetSize.width / width , targetSize.height / height)

        let x = (CGFloat(width) - size.width) / 2.0
        let y = (CGFloat(height) - size.height) / 2.0

        let cropRect = CGRect(x: x + 100, y: y, width: size.height, height: size.width)
        guard let cgImage = cgImage else {
            return self
        }
        guard let imageRef = cgImage.cropping(to: cropRect) else {
            return self
        }
        let cropped = UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)

        return cropped
    }
}
