//
//  ProfileViewModel.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

protocol ProfileViewModelProtocol {
    var user: User? { get }
    var products: [Product] { get }
    var filteredProducts: [Product] { get }
    var isLoading: ((Bool) -> Void)? { get set }
    var didUpdate: (() -> Void)? { get set }
    var didFail: ((String) -> Void)? { get set }
    
    func fetchUser()
    func fetchProducts()
    func search(with text: String)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    private let apiService: APIServiceProtocol
    var user: User?
    var products: [Product] = []
    var filteredProducts: [Product] = []
    
    var isLoading: ((Bool) -> Void)?
    var didUpdate: (() -> Void)?
    var didFail: ((String) -> Void)?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchUser() {
        isLoading?(true)
        apiService.fetch(endpoint: Endpoints.user) { [weak self] (result: Result<User, Error>) in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .success(let user):
                    self?.user = user
                    self?.didUpdate?()
                case .failure(let error):
                    self?.didFail?(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchProducts() {
        isLoading?(true)
        apiService.fetch(endpoint: Endpoints.products) { [weak self] (result: Result<[Product], Error>) in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .success(let products):
                    self?.products = products
                    self?.filteredProducts = products
                    self?.didUpdate?()
                case .failure(let error):
                    self?.didFail?(error.localizedDescription)
                }
            }
        }
    }
    
    func search(with text: String) {
        if text.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
        didUpdate?()
    }
}
