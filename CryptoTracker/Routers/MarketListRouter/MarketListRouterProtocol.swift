//
//  MarketListRouterProtocol.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 5.07.2023.
//

import Foundation
import UIKit

protocol MarketListRouterProtocol {
    func route(to routeID: Route, from context: UIViewController, orderIndex: IndexPath, viewModel: MarketListViewModelProtocol)
}
