//
//  ProfileViewController.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let viewModel = ProfileViewModel()
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUser()
        viewModel.fetchProducts()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        searchBar.placeholder = "Search products"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, nameLabel])
        profileStack.axis = .vertical
        profileStack.spacing = 8
        profileStack.alignment = .center
        
        let stack = UIStackView(arrangedSubviews: [profileStack, searchBar, tableView])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.isLoading = { loading in
            // TODO: - Loading Handling
        }
        
        viewModel.didUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        viewModel.didFail = { error in
            // TODO: - Error Handling
        }
    }
    
    private func updateUI() {
        if let user = viewModel.user {
            nameLabel.text = user.name
            profileImageView.loadImage(from: user.image)
        }
        tableView.reloadData()
    }
}

// MARK: - Search Bar Delegate
extension ProfileViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
    }
}

// MARK: - TableView Delegate & DataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        let product = viewModel.filteredProducts[indexPath.row]
        cell.configure(with: product)
        return cell
    }
}
