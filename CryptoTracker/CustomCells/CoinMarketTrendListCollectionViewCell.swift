//
//  CoinMarketTrendListCollectionViewCell.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 6.07.2023.
//

import Foundation
import UIKit

class CoinMarketTrendListCollectionViewCell: UICollectionViewCell {

    private lazy var mainView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .white
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 10
        temp.layer.masksToBounds = true
        temp.clipsToBounds = true
        return temp
    }()
    
    private lazy var coinImageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 10
        temp.layer.masksToBounds = true
        temp.clipsToBounds = true
        temp.backgroundColor = .secondarySystemBackground
        temp.contentMode = .scaleAspectFill
        return temp
    }()
    
    private lazy var coinSymbolLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 14, weight: .bold)
        temp.textColor = UIColor.black
        return temp
    }()
    
    private lazy var coinUnitPrice: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 20, weight: .bold)
        temp.textColor = UIColor.black
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        activateConstraints()
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
    
    private func setupUI() {
        contentView.addSubview(mainView)
        mainView.addSubview(coinImageView)
        mainView.addSubview(coinSymbolLabel)
        mainView.addSubview(coinUnitPrice)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            coinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            coinImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            //coinImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            coinImageView.widthAnchor.constraint(equalToConstant: 20),
            coinImageView.heightAnchor.constraint(equalToConstant: 20),
            
            coinSymbolLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            coinSymbolLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 10),
            coinSymbolLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            
            coinUnitPrice.topAnchor.constraint(equalTo: coinSymbolLabel.bottomAnchor, constant: 15),
            coinUnitPrice.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            coinUnitPrice.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with itemModel: Item) {
        guard let customImageUrl = URL(string: itemModel.small) else { return }
        coinImageView.kf.indicatorType = .activity
        coinImageView.kf.setImage(with: customImageUrl)
        
        coinSymbolLabel.text = itemModel.symbol.uppercased()
        coinUnitPrice.text = itemModel.priceBtc.withCommas()
    }
}
