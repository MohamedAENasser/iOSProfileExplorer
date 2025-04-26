//
//  ProductCell.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

class ProductCell: UITableViewCell {
    private var countdownTimer: Timer?
    private var endDate: Date?

    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let countdownLabel = UILabel()
    let specialOfferLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUI() {
        let stack = UIStackView(arrangedSubviews: [nameLabel, priceLabel, countdownLabel, specialOfferLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "Price: \(product.price) USD"
        specialOfferLabel.text = product.isSpecialOffer ? "🎉 Special Offer!" : ""
        specialOfferLabel.textColor = .systemRed
        specialOfferLabel.isHidden = !product.isSpecialOffer

        endDate = product.endDate
        updateCountdown()
        startTimer()
    }

    private func startTimer() {
        countdownTimer?.invalidate()
        guard endDate != nil else {
            countdownLabel.text = nil
            return
        }

        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc private func updateCountdown() {
        guard let endDate else { return }

        let now = Date()
        let remaining = endDate.timeIntervalSince(now)

        if remaining <= 0 {
            countdownLabel.text = "Ended"
            countdownTimer?.invalidate()
        } else {
            let hours = Int(remaining) / 3600
            let minutes = (Int(remaining) % 3600) / 60
            let seconds = Int(remaining) % 60
            countdownLabel.text = String(format: "⏳ %02d:%02d:%02d", hours, minutes, seconds)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        countdownTimer?.invalidate()
        countdownLabel.text = ""
    }
}
