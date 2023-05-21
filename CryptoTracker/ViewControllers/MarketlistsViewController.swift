//
//  MarketlistsViewController.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 22.03.2023.
//

import UIKit

class MarketlistsViewController: UIViewController {

    private let viewModelProtocol: MarketListViewModelProtocol
    
    init(viewModelProtocol: MarketListViewModelProtocol) {
        self.viewModelProtocol = viewModelProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
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
        viewModelProtocol.fetchMarketList(pagination: false)
        viewModelProtocol.subscribeListChange { [weak self] in
            self?.coinMarketTableView.reloadData()
            self?.coinMarketTableView.tableFooterView = nil
        }
        viewModelProtocol.subscribeListChangeError { [weak self] in
            PopUpManager.shared.showAlertView()
            self?.coinMarketTableView.tableFooterView = nil
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

extension MarketlistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelProtocol.returnMarketTableViewListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = coinMarketTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.marketListCellIdentifier.value,
                                                                 for: indexPath) as? CoinMarketListTableViewCell else {
            fatalError()
        }
        
        if let cellModelItem = viewModelProtocol.returnMarketTableViewList(order: indexPath) {
            cell.configure(with: cellModelItem)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        
        if position > coinMarketTableView.contentSize.height - 100 - scrollView.frame.size.height {
            // fetch more data
            guard !CoinsMarketService.shared.isPaginating else {
                return
            }
            self.coinMarketTableView.tableFooterView = viewModelProtocol.returnLoadingAnimationFooter(customView: self.view)
            viewModelProtocol.fetchMarketList(pagination: true)
            print("data fetched")
        }
    }
}

