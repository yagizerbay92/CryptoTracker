//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 22.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var coinMarketTableView: UITableView = {
        let temp = UITableView()
        temp.register(CoinMarketListTableViewCell.self,
                      forCellReuseIdentifier: CellIdentifiers.marketListCellIdentifier.value)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = self
        temp.dataSource = self
        return temp
    }()
    
    public var marketList: [MarketLisItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        activeConstraints()
        CoinsMarketService.shared.getMarketList { [weak self] result in
            switch result {
            case .success(let success):
                self?.marketList = success
                self?.coinMarketTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupUI() {
        title = "Crypto Tracker"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(coinMarketTableView)
    }
    
    private func activeConstraints() {
        NSLayoutConstraint.activate([
            coinMarketTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            coinMarketTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            coinMarketTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            coinMarketTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cellModelItem = marketList {
            return cellModelItem.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = coinMarketTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.marketListCellIdentifier.value,
                                                                 for: indexPath) as? CoinMarketListTableViewCell else {
            fatalError()
        }
        
        if let cellModelItem = marketList {
            cell.configure(with: cellModelItem[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

