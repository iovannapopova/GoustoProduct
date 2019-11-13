//
//  TableViewCell.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import UIKit

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
        self.imageView?.layer.cornerRadius = 5.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.price
        imageView?.image = nil
        guard let imageURL = viewModel.imageURL else {
            let image = UIImage(named: "no-image")!
            imageView?.image = image.resize(toTargetSize: CGSize(width: 80.0, height: 80.0))
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
                let image = UIImage(data: data, scale: UIScreen.main.scale)!
                self.imageView?.image = image.resize(toTargetSize: CGSize(width: 88.0, height: 88.0))
                self.setNeedsLayout()

            }
        }
        task.resume()
    }

}

extension UIImage {

    func resize(toTargetSize targetSize: CGSize) -> UIImage {

        let newScale = self.scale // change this if you want the output image to have a different scale
        let originalSize = self.size

        let widthRatio = targetSize.width / originalSize.width
        let heightRatio = targetSize.height / originalSize.height

        // Figure out what our orientation is, and use that to form the rectangle
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: floor(originalSize.width * heightRatio), height: floor(originalSize.height * heightRatio))
        } else {
            newSize = CGSize(width: floor(originalSize.width * widthRatio), height: floor(originalSize.height * widthRatio))
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)

        // Actually do the resizing to the rect using the ImageContext stuff
        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale
        format.opaque = true
        let newImage = UIGraphicsImageRenderer(bounds: rect, format: format).image() { _ in
            self.draw(in: rect)
        }

        return newImage
    }

    func cropImage(image: UIImage, size: CGSize, center: CGPoint) -> UIImage {
        guard let cgImage = image.cgImage else {
            return image
        }
        let rect =  CGRect(origin: center, size: size)
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
}
