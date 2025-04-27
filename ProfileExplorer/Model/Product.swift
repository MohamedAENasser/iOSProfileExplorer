//
//  Product.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
    let image: String
    let endDate: String
    let specialLabel: String?
}
