//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 22.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    public var marketList: [MarketLisItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        CoinsMarketService.shared.getMarketList { [weak self] result in
            switch result {
            case .success(let success):
                self?.marketList = success
                print(self?.marketList?[3].name ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
}

