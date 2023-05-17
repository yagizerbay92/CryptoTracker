//
//  MarketListsViewModel.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 19.04.2023.
//

import Foundation
import UIKit

public typealias MarketListCallback = (() -> Void)

class MarketListsViewModel {
    private var marketListCallback: MarketListCallback?
    private var paginationCount: Int = 1
    private var marketList: [MarketLisItem]? {
        didSet {
            marketListCallback?()
        }
    }

    public init() {}
    
    private func callMarketList(pagination: Bool, paginationValue: Int) {
        CoinsMarketService.shared.getMarketList(pagination: pagination,
                                                paginationValue: paginationValue,
                                                completion: { [weak self] result in
            switch result {
            case .success(let success):
                if pagination {
                    self?.marketList?.append(contentsOf: success)
                } else {
                    self?.marketList = success
                }
            case .failure(let error):
                print(error)
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
    
    func fetchMarketList(pagination: Bool, paginationValue: Int) {
        callMarketList(pagination: pagination, paginationValue: paginationValue)
    }
    
    func returnMarketTableViewListCount() -> Int {
        return marketList?.count ?? 0
    }
    
    func returnMarketTableViewList(order: IndexPath) -> MarketLisItem? {
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
}
