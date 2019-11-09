//
//  ProductDetailViewModel.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import Foundation

struct ProductDetailViewModel: Equatable {
    let title: String
    let description: String
    let price: String
    let imageURL: URL?
}
