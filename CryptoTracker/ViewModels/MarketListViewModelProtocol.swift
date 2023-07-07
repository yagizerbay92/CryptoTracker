//
//  MarketListViewModelProtocol.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 19.04.2023.
//

import Foundation
import UIKit

protocol MarketListViewModelProtocol: AnyObject {
    func subscribeListChange(with completion: @escaping MarketListCallback)
    func subscribeMarketTrendListChange(with completion: @escaping MarketTrendListCallback)
    func fetchMarketList(pagination: Bool)
    func fetchMarketTrendList()
    func returnMarketTableViewListCount() -> Int
    func returnMarketTableViewListItem(order: IndexPath) -> MarketLisItem?
    func returnLoadingAnimationFooter(customView: UIView) -> UIView
    func returnPaginationCount() -> Int
    func startPaginationCount()
    func subscribeListChangeError(with completion: @escaping MarketListErrorCallback)
    func subscribeMarketTrendListChangeError(with completion: @escaping MarketTrendListErrorCallback)
    func returnCurrentPrice(order: IndexPath) -> String
    func returnBitcoinImage(order: IndexPath) -> String
    func returnCoinName(order: IndexPath) -> String
    func returnCoinSymbol(order: IndexPath) -> String
    func returnCoinPercentage(order: IndexPath) -> Double
    func returnMarketCap(order: IndexPath) -> String
    func returnTotalVolume(order: IndexPath) -> String
    func returnCirculatingSupply(order: IndexPath) -> String
    func returnItemList(order: IndexPath) -> Item?
    func returnItemCount() -> Int
}
