//
//  APIService.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
}

protocol APIServiceProtocol {
    func fetchUser(completion: @escaping (Result<User, APIError>) -> Void)
    func fetchProducts(query: String?, completion: @escaping (Result<[Product], APIError>) -> Void)
    func fetchAdvertisements(completion: @escaping (Result<[Advertisement], APIError>) -> Void)
    func fetchTags(completion: @escaping (Result<[Tag], APIError>) -> Void)
}

class APIService: APIServiceProtocol {
    private let baseURL = "https://stagingapi.mazaady.com/api/interview-tasks"

    func fetchUser(completion: @escaping (Result<User, APIError>) -> Void) {
        request(endpoint: "/user", completion: completion)
    }

    func fetchProducts(query: String?, completion: @escaping (Result<[Product], APIError>) -> Void) {
        var urlString = "\(baseURL)/products"
        if let query = query, !query.isEmpty {
            urlString += "?name=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        request(urlString: urlString, completion: completion)
    }

    func fetchAdvertisements(completion: @escaping (Result<[Advertisement], APIError>) -> Void) {
        request(endpoint: "/advertisements", completion: completion)
    }

    func fetchTags(completion: @escaping (Result<[Tag], APIError>) -> Void) {
        request(endpoint: "/tags", completion: completion)
    }

    // MARK: - Private Generic Request
    private func request<T: Decodable>(endpoint: String, completion: @escaping (Result<T, APIError>) -> Void) {
        let urlString = baseURL + endpoint
        request(urlString: urlString, completion: completion)
    }

    private func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
