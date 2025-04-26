//
//  User.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
    }
}
