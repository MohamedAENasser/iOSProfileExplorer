//
//  APIService.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchProducts(query: String?, completion: @escaping (Result<[Product], Error>) -> Void)
}

class APIService: APIServiceProtocol {
    func fetchProducts(query: String?, completion: @escaping (Result<[Product], Error>) -> Void) {
        
    }
}
