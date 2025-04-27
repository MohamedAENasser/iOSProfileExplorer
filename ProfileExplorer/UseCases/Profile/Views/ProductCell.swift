//
//  ProductCell.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    static let identifier = "ProductCell"
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let offerLabel = UILabel()
    private let countdownLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        
        priceLabel.font = .systemFont(ofSize: 12, weight: .bold)
        priceLabel.textAlignment = .center
        
        offerLabel.font = .systemFont(ofSize: 10, weight: .bold)
        offerLabel.textColor = .systemRed
        offerLabel.textAlignment = .center
        
        countdownLabel.font = .systemFont(ofSize: 10, weight: .regular)
        countdownLabel.textColor = .systemBlue
        countdownLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel, priceLabel, offerLabel, countdownLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor) // Image square
        ])
    }
    
    func configure(with product: Product) {
        imageView.loadImage(from: product.image) // Assuming a URL loading extension
        nameLabel.text = product.name
        priceLabel.text = "\(product.price)$"
        offerLabel.text = product.specialLabel
    }
}
