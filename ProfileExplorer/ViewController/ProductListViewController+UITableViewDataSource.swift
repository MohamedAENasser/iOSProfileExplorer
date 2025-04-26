//
//  ProductListViewController+UITableViewDataSource.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = viewModel.product(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = product.name
        return cell
    }
}
