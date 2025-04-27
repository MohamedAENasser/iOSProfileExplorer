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
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
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
        
        let stack = UIStackView(arrangedSubviews: [profileStack, searchBar, collectionView])
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
        collectionView.reloadData()
    }
}

// MARK: - Search Bar Delegate
extension ProfileViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
    }
}

// MARK: - Collection Delegate & DataSource
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let product = viewModel.filteredProducts[indexPath.item]
        cell.configure(with: product)
        return cell
    }
    
    // MARK: - Grid Layout 3 columns
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalSpacing: CGFloat = 8 * 2 + 8 * 2  // 2 sides + 2 spaces between cells
        let width = (collectionView.frame.width - totalSpacing) / 3
        
        return CGSize(width: width, height: width + 60) // Height to fit image + text
    }
}
