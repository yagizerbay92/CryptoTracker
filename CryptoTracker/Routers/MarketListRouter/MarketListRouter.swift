//
//  LoginRouter.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 4.07.2023.
//

import Foundation
import UIKit

class MarketListRouter {
    
}

extension MarketListRouter {
    func route(to routeID: Route, from context: UIViewController, orderIndex: IndexPath, viewModel: MarketListViewModelProtocol) {
        
        switch routeID {
        case .marketItemDetail:
            let vc = MarketListItemDetailViewController(viewModelProtocol: viewModel, selectedIndex: orderIndex)
            context.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
