//
//  TagsViewModel.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

protocol TagsViewModelProtocol {
    var tags: [Tag] { get }
    var isLoading: ((Bool) -> Void)? { get set }
    var didUpdate: (() -> Void)? { get set }
    var didFail: ((String) -> Void)? { get set }
    
    func fetchTags()
}

final class TagsViewModel: TagsViewModelProtocol {
    
    private let apiService: APIServiceProtocol
    var tags: [Tag] = []
    
    var isLoading: ((Bool) -> Void)?
    var didUpdate: (() -> Void)?
    var didFail: ((String) -> Void)?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchTags() {
        isLoading?(true)
        apiService.fetch(endpoint: Endpoints.tags) { [weak self] (result: Result<[Tag], Error>) in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .success(let tags):
                    self?.tags = tags
                    self?.didUpdate?()
                case .failure(let error):
                    self?.didFail?(error.localizedDescription)
                }
            }
        }
    }
}
