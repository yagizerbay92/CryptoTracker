//
//  MarketlistsViewController.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 22.03.2023.
//

import UIKit

class MarketlistsViewController: UIViewController {

    private let viewModelProtocol: MarketListViewModelProtocol
    private let router: MarketListRouterProtocol
    
    init(viewModelProtocol: MarketListViewModelProtocol, router: MarketListRouterProtocol) {
        self.viewModelProtocol = viewModelProtocol
        self.router = router
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
        temp.separatorStyle = .none
        return temp
    }()
    
    private lazy var coinMarketTrendCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSizeMake(100, 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.register(CoinMarketTrendListCollectionViewCell.self,
                      forCellWithReuseIdentifier: "CoinMarketTrendListCollectionViewCell")
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = self
        temp.dataSource = self
        temp.backgroundColor = .clear
        return temp
    }()
    
    public var marketList: [MarketLisItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        activeConstraints()
        
        viewModelProtocol.fetchMarketTrendList()
        viewModelProtocol.subscribeMarketTrendListChange { [weak self] in
            self?.coinMarketTrendCollectionView.reloadData()
        }
        
        viewModelProtocol.subscribeMarketTrendListChangeError { [weak self] in
            PopUpManager.shared.showAlertView()
        }
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hideHairline()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        title = "Crypto Tracker"
        view.backgroundColor = .systemGreen
        view.addSubview(coinMarketTrendCollectionView)
        view.addSubview(coinMarketTableView)
    }
    
    private func activeConstraints() {
        NSLayoutConstraint.activate([
            coinMarketTrendCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            coinMarketTrendCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            coinMarketTrendCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            coinMarketTrendCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            coinMarketTableView.topAnchor.constraint(equalTo: self.coinMarketTrendCollectionView.bottomAnchor, constant: 20),
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
        
        if let cellModelItem = viewModelProtocol.returnMarketTableViewListItem(order: indexPath) {
            cell.configure(with: cellModelItem)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coinMarketTableView.deselectRow(at: indexPath, animated: true)
        router.route(to: .marketItemDetail, from: self, orderIndex: indexPath, viewModel: viewModelProtocol)
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

extension MarketlistsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelProtocol.returnItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = coinMarketTrendCollectionView.dequeueReusableCell(withReuseIdentifier: "CoinMarketTrendListCollectionViewCell",
                                                                           for: indexPath) as? CoinMarketTrendListCollectionViewCell else {
            fatalError()
        }
        
        if let cellModelItem = viewModelProtocol.returnItemList(order: indexPath) {
            cell.configure(with: cellModelItem)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}
