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
    func fetchMarketList(pagination: Bool, paginationValue: Int)
    func returnMarketTableViewListCount() -> Int
    func returnMarketTableViewList(order: IndexPath) -> MarketLisItem?
    func returnLoadingAnimationFooter(customView: UIView) -> UIView
    func returnPaginationCount() -> Int
    func startPaginationCount()
}
