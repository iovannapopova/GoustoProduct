//
//  Product.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

//"images": {
//"750": {
//"src": "https://production-media.gousto.co.uk/cms/product-image-landscape/BKD-mini-baking-kit_happy-bunny-cupcakes-0114-x750.jpg",
//"url": "https://production-media.gousto.co.uk/cms/product-image-landscape/BKD-mini-baking-kit_happy-bunny-cupcakes-0114-x750.jpg",
//"width": 750
//}
//}

struct Products: Codable {
    let data: [Product]
}

struct Product: Codable {
//    let id: String
//    let sku: String
    let title: String
//    let description: String
    let listPrice: String?
    let images: [String: ImageSources?]
//    let isVatable: Bool?
//    let isForSale: Bool?
//    let ageRestricted: Bool?
//    let boxLimit: Int?
//    let alwaysOnMenu: Bool?
//    let volume: Int?
//    let zone: String?
//    let createdAt: String?
}

struct ImageSources: Codable {
    let src: String
    let url: String
    let width: Int
}

extension Product {
    private enum Keys: String, CodingKey {
        case title
        case listPrice = "list_price"
        case images
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        title = try container.decode(String.self, forKey: .title)
        listPrice = try container.decode(String.self, forKey: .listPrice)
        images = try container.decode([String: ImageSources?].self, forKey: .images)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(title, forKey: .title)
        try container.encode(listPrice, forKey: .listPrice)
        try container.encode(images, forKey: .images)
    }
}
