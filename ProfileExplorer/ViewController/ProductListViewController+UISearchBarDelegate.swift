//
//  ProductListViewController+UISearchBarDelegate.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

// MARK: - UISearchBarDelegate
extension ProductListViewController: UISearchBarDelegate {
    // Search Setup
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search products..."
        navigationItem.titleView = searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWorkItem?.cancel()
        let task = DispatchWorkItem { [weak self] in
            self?.viewModel.fetchProducts(query: searchText)
        }
        searchWorkItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task) // debounce
    }
}
