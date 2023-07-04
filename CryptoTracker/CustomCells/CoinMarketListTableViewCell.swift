//
//  CoinMarketListTableViewCell.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 14.04.2023.
//

import Foundation
import UIKit
import Kingfisher

class CoinMarketListTableViewCell: UITableViewCell {
    
    private lazy var coinImageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 25
        temp.layer.masksToBounds = true
        temp.clipsToBounds = true
        temp.backgroundColor = .secondarySystemBackground
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    private lazy var coinTitleLabel: UILabel = {
        let temp = UILabel()
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 14, weight: .bold)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var coinCurrentPriceLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .right
        temp.numberOfLines = 1
        temp.font = .systemFont(ofSize: 14, weight: .bold)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var coinSymbolLabel: UILabel = {
        let temp = UILabel()
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 12, weight: .regular)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var coinMarketCapPercLabel: UILabel = {
        let temp = UILabel()
        temp.numberOfLines = 0
        temp.textAlignment = .right
        temp.font = .systemFont(ofSize: 12, weight: .semibold)
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        activateConstraints()
    }
    
    private func setupUI() {
        contentView.addSubview(coinImageView)
        contentView.addSubview(coinTitleLabel)
        contentView.addSubview(coinCurrentPriceLabel)
        contentView.addSubview(coinSymbolLabel)
        contentView.addSubview(coinMarketCapPercLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            coinImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            coinImageView.widthAnchor.constraint(equalToConstant: 50),
            coinImageView.heightAnchor.constraint(equalToConstant: 10),
            
            coinTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            coinTitleLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            coinTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            coinTitleLabel.bottomAnchor.constraint(equalTo: coinSymbolLabel.topAnchor, constant: -5),
            
            coinSymbolLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            coinSymbolLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            
            coinCurrentPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            coinCurrentPriceLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            coinCurrentPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            coinMarketCapPercLabel.topAnchor.constraint(equalTo: coinCurrentPriceLabel.bottomAnchor, constant: 5),
            coinMarketCapPercLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            coinMarketCapPercLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with newsFeedModel: MarketLisItem) {
        guard let customImageUrl = URL(string: newsFeedModel.image ?? "") else { return }
        coinImageView.kf.indicatorType = .activity
        coinImageView.kf.setImage(with: customImageUrl)
        
        coinTitleLabel.text = newsFeedModel.name
        coinSymbolLabel.text = newsFeedModel.symbol?.uppercased()
        
        guard let capPercentage = newsFeedModel.marketCapChangePercentage24H,
        let currentPrice = newsFeedModel.currentPrice else { return }
        
        coinCurrentPriceLabel.text = String(currentPrice.rounded(toPlaces: 2)).dolarSignAppended()
        
        if capPercentage >= 0.0 {
            coinMarketCapPercLabel.textColor = UIColor.systemGreen
            coinMarketCapPercLabel.text = String(capPercentage.rounded(toPlaces: 2)).replacingOccurrences(of: ",", with: ".")
                .plusSignAppended()
                .percentageSignAppended()
            
        } else {
            coinMarketCapPercLabel.textColor = UIColor.red
            coinMarketCapPercLabel.text = String(capPercentage.rounded(toPlaces: 2)).replacingOccurrences(of: ",", with: ".").percentageSignAppended()
        }
    }
}
