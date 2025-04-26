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
    let imageUrl: String
    let price: Double
    let endDate: Date?
    let isSpecialOffer: Bool
}
