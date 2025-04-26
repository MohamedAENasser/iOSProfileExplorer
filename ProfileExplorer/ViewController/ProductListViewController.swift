//
//  ProductListViewController.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

class ProductListViewController: UIViewController {
    private let tableView = UITableView()
    let viewModel = ProductListViewModel()
    
    let searchBar = UISearchBar()
    var searchWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        
        bindViewModel()
        viewModel.fetchProducts()
        
    }
    
    private func setupUI() {
        title = "Products"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func bindViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
