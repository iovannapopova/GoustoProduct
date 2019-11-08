//
//  Product.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

struct Products: Codable {
    let data: [Product]
}

struct Product: Codable {
    let id: String
    let sku: String
    let title: String
    let description: String
    let listPrice: String?
    let isVatable: Bool?
    let isForSale: Bool?
    let ageRestricted: Bool?
    let boxLimit: Int?
    let alwaysOnMenu: Bool?
    let volume: Int?
    let zone: String?
    let createdAt: String?
}
