//
//  MarketListItemDetailViewController.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 25.05.2023.
//

import Foundation
import UIKit
import Kingfisher

class MarketListItemDetailViewController: UIViewController {
    
    private let viewModelProtocol: MarketListViewModelProtocol
    private let selectedIndex: IndexPath
    
    init(viewModelProtocol: MarketListViewModelProtocol, selectedIndex: IndexPath) {
        self.viewModelProtocol = viewModelProtocol
        self.selectedIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
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
    
    private lazy var coinHeaderLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.font = .systemFont(ofSize: 22, weight: .bold)
        return temp
    }()
    
    private lazy var coinSymbolLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.gray
        temp.font = .systemFont(ofSize: 15, weight: .bold)
        return temp
    }()
    
    private lazy var priceHeaderLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.black
        temp.font = .systemFont(ofSize: 20, weight: .bold)
        return temp
    }()
    
    private lazy var priceLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.gray
        temp.font = .systemFont(ofSize: 16, weight: .semibold)
        return temp
    }()
    
    private lazy var coinPercentageHeaderLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.black
        temp.font = .systemFont(ofSize: 20, weight: .bold)
        return temp
    }()
    
    private lazy var coinPercentageLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.gray
        temp.font = .systemFont(ofSize: 16, weight: .semibold)
        return temp
    }()
    
    private lazy var marketCapHeaderLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.black
        temp.font = .systemFont(ofSize: 20, weight: .bold)
        return temp
    }()
    
    private lazy var marketCapLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.gray
        temp.font = .systemFont(ofSize: 16, weight: .semibold)
        return temp
    }()
    
    private lazy var volumeHeaderLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.black
        temp.font = .systemFont(ofSize: 20, weight: .bold)
        return temp
    }()
    
    private lazy var volumeLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.gray
        temp.font = .systemFont(ofSize: 16, weight: .semibold)
        return temp
    }()
    
    private lazy var circulatingSupplyHeaderLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.black
        temp.font = .systemFont(ofSize: 20, weight: .bold)
        return temp
    }()
    
    private lazy var circulatingSupplyLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.numberOfLines = 0
        temp.textColor = UIColor.gray
        temp.font = .systemFont(ofSize: 16, weight: .semibold)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUIElements()
        activeConstraints()
        title = "Crypto Detail"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupUI() {
        view.addSubview(coinImageView)
        view.addSubview(coinHeaderLabel)
        view.addSubview(coinSymbolLabel)
        view.addSubview(priceHeaderLabel)
        view.addSubview(priceLabel)
        view.addSubview(coinPercentageHeaderLabel)
        view.addSubview(coinPercentageLabel)
        view.addSubview(marketCapHeaderLabel)
        view.addSubview(marketCapLabel)
        view.addSubview(volumeHeaderLabel)
        view.addSubview(volumeLabel)
        view.addSubview(circulatingSupplyHeaderLabel)
        view.addSubview(circulatingSupplyLabel)
    }
    
    private func setupUIElements() {
        guard let customImageUrl = URL(string: viewModelProtocol.returnBitcoinImage(order: selectedIndex) ) else { return }
        coinImageView.kf.setImage(with: customImageUrl)
        
        coinHeaderLabel.text = viewModelProtocol.returnCoinName(order: selectedIndex)
        coinSymbolLabel.text = viewModelProtocol.returnCoinSymbol(order: selectedIndex).uppercased()
        
        priceHeaderLabel.text = "Price"
        priceLabel.text = viewModelProtocol.returnCurrentPrice(order: selectedIndex)
        
        coinPercentageHeaderLabel.text = "(%)"
        
        let capPercentage = viewModelProtocol.returnCoinPercentage(order: selectedIndex)
        if capPercentage >= 0.0 {
            coinPercentageLabel.textColor = UIColor.systemGreen
            coinPercentageLabel.text = String(capPercentage.rounded(toPlaces: 2)).replacingOccurrences(of: ",", with: ".")
                .plusSignAppended()
                .percentageSignAppended()
            
        } else {
            coinPercentageLabel.textColor = UIColor.red
            coinPercentageLabel.text = String(capPercentage.rounded(toPlaces: 2)).replacingOccurrences(of: ",", with: ".").percentageSignAppended()
        }
    
        marketCapHeaderLabel.text = "Market Cap"
        marketCapLabel.text = viewModelProtocol.returnMarketCap(order: selectedIndex)
        
        volumeHeaderLabel.text = "Volume (24h)"
        volumeLabel.text = viewModelProtocol.returnTotalVolume(order: selectedIndex)
        
        circulatingSupplyHeaderLabel.text = "Circulating Supply"
        circulatingSupplyLabel.text = viewModelProtocol.returnCirculatingSupply(order: selectedIndex)
    }
    
    private func activeConstraints() {
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            coinImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            coinImageView.widthAnchor.constraint(equalToConstant: 50),
            coinImageView.heightAnchor.constraint(equalToConstant: 50),
            
            coinHeaderLabel.centerYAnchor.constraint(equalTo: self.coinImageView.centerYAnchor),
            coinHeaderLabel.leadingAnchor.constraint(equalTo: self.coinImageView.trailingAnchor, constant: 10),
            
            coinSymbolLabel.bottomAnchor.constraint(equalTo: self.coinHeaderLabel.bottomAnchor, constant: -2),
            coinSymbolLabel.leadingAnchor.constraint(equalTo: self.coinHeaderLabel.trailingAnchor, constant: 5),
            coinSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
            priceHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            priceHeaderLabel.topAnchor.constraint(equalTo: self.coinImageView.bottomAnchor, constant: 20),
            
            priceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            priceLabel.topAnchor.constraint(equalTo: self.priceHeaderLabel.bottomAnchor, constant: 5),
            
            coinPercentageHeaderLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            coinPercentageHeaderLabel.centerYAnchor.constraint(equalTo: self.priceHeaderLabel.centerYAnchor),
            
            coinPercentageLabel.topAnchor.constraint(equalTo: coinPercentageHeaderLabel.bottomAnchor, constant: 5),
            coinPercentageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            marketCapHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            marketCapHeaderLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 20),
            
            marketCapLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            marketCapLabel.topAnchor.constraint(equalTo: self.marketCapHeaderLabel.bottomAnchor, constant: 5),
            
            volumeHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            volumeHeaderLabel.topAnchor.constraint(equalTo: self.marketCapLabel.bottomAnchor, constant: 20),
            
            volumeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            volumeLabel.topAnchor.constraint(equalTo: self.volumeHeaderLabel.bottomAnchor, constant: 5),
            
            circulatingSupplyHeaderLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            circulatingSupplyHeaderLabel.topAnchor.constraint(equalTo: self.volumeLabel.bottomAnchor, constant: 20),
            
            circulatingSupplyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            circulatingSupplyLabel.topAnchor.constraint(equalTo: self.circulatingSupplyHeaderLabel.bottomAnchor, constant: 5)
        ])
    }
}
