//
//  AdsViewModelProtocol.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

protocol AdsViewModelProtocol {
    var ads: [Advertisement] { get }
    var isLoading: ((Bool) -> Void)? { get set }
    var didUpdate: (() -> Void)? { get set }
    var didFail: ((String) -> Void)? { get set }
    
    func fetchAds()
}

final class AdsViewModel: AdsViewModelProtocol {
    
    private let apiService: APIServiceProtocol
    var ads: [Advertisement] = []
    
    var isLoading: ((Bool) -> Void)?
    var didUpdate: (() -> Void)?
    var didFail: ((String) -> Void)?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchAds() {
        isLoading?(true)
        apiService.fetch(endpoint: Endpoints.ads) { [weak self] (result: Result<[Advertisement], Error>) in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .success(let ads):
                    self?.ads = ads
                    self?.didUpdate?()
                case .failure(let error):
                    self?.didFail?(error.localizedDescription)
                }
            }
        }
    }
}
