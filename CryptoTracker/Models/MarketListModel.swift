//
//  MarketListModel.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 8.04.2023.
//

import Foundation

struct MarketLisItem: Codable {
    let symbol: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let marketCapChangePercentage24H: Double?
    let marketCap: Double?
    let totalVolume: Double?
    let circulatingSupply: Double?
    
    enum CodingKeys: String, CodingKey {
        case symbol, name, image
        case currentPrice = "current_price"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case circulatingSupply = "circulating_supply"
    }
}
