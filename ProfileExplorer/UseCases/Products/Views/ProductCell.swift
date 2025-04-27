//
//  ProductCell.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    static let identifier = "ProductCell"
    
    private let productImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let countdownLabel = UILabel()
    private let specialOfferLabel = UILabel()
    
    private var timer: CountdownTimer?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 8
        productImageView.layer.masksToBounds = true
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .systemFont(ofSize: 16)
        priceLabel.font = .systemFont(ofSize: 14)
        countdownLabel.font = .systemFont(ofSize: 14)
        countdownLabel.textColor = .systemRed
        
        specialOfferLabel.font = .boldSystemFont(ofSize: 12)
        specialOfferLabel.textColor = .white
        specialOfferLabel.backgroundColor = .systemGreen
        specialOfferLabel.textAlignment = .center
        specialOfferLabel.layer.cornerRadius = 4
        specialOfferLabel.clipsToBounds = true
        
        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel, countdownLabel, specialOfferLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 4
        
        let mainStack = UIStackView(arrangedSubviews: [productImageView, labelsStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with product: Product) {
        productImageView.loadImage(from: product.image)
        nameLabel.text = product.name
        priceLabel.text = String(format: "$%.2f", product.price)
        specialOfferLabel.isHidden = product.specialLabel == nil
        specialOfferLabel.text = product.specialLabel
        
        timer?.stop()
        timer = CountdownTimer()
        if let endDate = ISO8601DateFormatter().date(from: product.endDate) {
            timer?.start(endDate: endDate) { [weak self] timeString in
                self?.countdownLabel.text = timeString
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.stop()
        timer = nil
    }
}
