//
//  ProductListViewModel.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

class ProductListViewModel {
    private var products: [Product] = []
    private let apiService: APIServiceProtocol

    var reloadData: (() -> Void)?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchProducts(query: String? = nil) {
        apiService.fetchProducts(query: query) { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.reloadData?()
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }

    func numberOfItems() -> Int {
        products.count
    }

    func product(at index: Int) -> Product {
        products[index]
    }
}
