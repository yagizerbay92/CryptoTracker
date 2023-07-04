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

class MarketListsViewModel {
    private var marketListCallback: MarketListCallback?
    private var marketListErrorCallback: MarketListErrorCallback?
    private var paginationCount: Int = 1
    private var marketList: [MarketLisItem]? {
        didSet {
            marketListCallback?()
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
    
    func fetchMarketList(pagination: Bool) {
        callMarketList(pagination: pagination)
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
        return String(price.rounded(toPlaces: 2)).dolarSignAppended()
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
        return String(marketCap.rounded(toPlaces: 2)).dolarSignAppended()
    }
    
    func returnTotalVolume(order: IndexPath) -> String {
        guard let totalVolume = marketList?[order.row].totalVolume else { return "0.0" }
        return String(totalVolume.rounded(toPlaces: 2)).dolarSignAppended()
    }
    
    func returnCirculatingSupply(order: IndexPath) -> String {
        guard let circulatingSupply = marketList?[order.row].circulatingSupply else { return "0.0" }
        return String(circulatingSupply.rounded(toPlaces: 2)).dolarSignAppended()
    }
}
