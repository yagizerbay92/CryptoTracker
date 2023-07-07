//
//  MarketListsViewModel.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 19.04.2023.
//

import Foundation
import UIKit

public typealias MarketListCallback = (() -> Void)
public typealias MarketListErrorCallback = (() -> Void)
public typealias MarketTrendListCallback = (() -> Void)
public typealias MarketTrendListErrorCallback = (() -> Void)

class MarketListsViewModel {
    private var marketListCallback: MarketListCallback?
    private var marketListErrorCallback: MarketListErrorCallback?
    private var marketTrendListCallback: MarketTrendListCallback?
    private var marketTrendListErrorCallback: MarketTrendListErrorCallback?
    private var paginationCount: Int = 1
    
    private var marketList: [MarketLisItem]? {
        didSet {
            marketListCallback?()
        }
    }
    
    private var marketTrendList: TrendLists? {
        didSet {
            marketTrendListCallback?()
        }
    }

    public init() {}
    
    private func callMarketList(pagination: Bool) {
        CoinsMarketService.shared.getMarketList(pagination: pagination,
                                                paginationValue: paginationCount,
                                                completion: { [weak self] result in
            switch result {
            case .success(let success):
                if pagination {
                    self?.marketList?.append(contentsOf: success)
                    self?.paginationCount += 1
                } else {
                    self?.marketList = success
                    self?.paginationCount = 2
                }
            case .failure(let error):
                self?.marketListErrorCallback?()
            }
        })
    }
    
    private func callMarketTrendList() {
        CoinsMarketTrendsService.shared.getMarketList(completion: { [weak self] result in
            switch result {
            case .success(let success):
                self?.marketTrendList = success
            case .failure(let error):
                self?.marketTrendListErrorCallback?()
            }
        })
    }
    
    private func createLoadingAnimationFooter(customView: UIView) -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: customView.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}

extension MarketListsViewModel: MarketListViewModelProtocol {
    func subscribeListChange(with completion: @escaping MarketListCallback) {
        marketListCallback = completion
    }
    
    func subscribeListChangeError(with completion: @escaping MarketListErrorCallback) {
        marketListErrorCallback = completion
    }
    
    func subscribeMarketTrendListChange(with completion: @escaping MarketTrendListCallback) {
        marketTrendListCallback = completion
    }
    
    func subscribeMarketTrendListChangeError(with completion: @escaping MarketTrendListErrorCallback) {
        marketTrendListErrorCallback = completion
    }
    
    func fetchMarketList(pagination: Bool) {
        callMarketList(pagination: pagination)
    }
    
    func fetchMarketTrendList() {
        callMarketTrendList()
    }
    
    func returnMarketTableViewListCount() -> Int {
        return marketList?.count ?? 0
    }
    
    func returnMarketTableViewListItem(order: IndexPath) -> MarketLisItem? {
        return marketList?[order.row]
    }

    func returnLoadingAnimationFooter(customView: UIView) -> UIView {
        createLoadingAnimationFooter(customView: customView)
    }
    
    func returnPaginationCount() -> Int {
        return paginationCount
    }
    
    func startPaginationCount() {
        paginationCount += 1
    }
    
    func returnCurrentPrice(order: IndexPath) -> String {
        guard let price = marketList?[order.row].currentPrice else { return "0.0" }
        return String(price.withCommas())
    }
    
    func returnBitcoinImage(order: IndexPath) -> String {
        return marketList?[order.row].image ?? ""
    }
    
    func returnCoinName(order: IndexPath) -> String {
        return marketList?[order.row].name ?? ""
    }
    
    func returnCoinSymbol(order: IndexPath) -> String {
        return marketList?[order.row].symbol ?? ""
    }
    
    func returnCoinPercentage(order: IndexPath) -> Double {
        return marketList?[order.row].marketCapChangePercentage24H ?? 0.0
    }
    
    func returnMarketCap(order: IndexPath) -> String {
        guard let marketCap = marketList?[order.row].marketCap else { return "0.0" }
        return String(marketCap.withCommas())
    }
    
    func returnTotalVolume(order: IndexPath) -> String {
        guard let totalVolume = marketList?[order.row].totalVolume else { return "0.0" }
        return String(totalVolume.withCommas())
    }
    
    func returnCirculatingSupply(order: IndexPath) -> String {
        guard let circulatingSupply = marketList?[order.row].circulatingSupply else { return "0.0" }
        return String(circulatingSupply.withCommas())
    }
    
    func returnItemList(order: IndexPath) -> Item? {
        return marketTrendList?.coins[order.row].item
    }
    
    func returnItemCount() -> Int {
        return marketTrendList?.coins.count ?? 0
    }
}
