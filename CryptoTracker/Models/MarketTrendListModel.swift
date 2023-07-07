//
//  MarketTrendListModel.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 5.07.2023.
//

import Foundation

struct TrendLists: Codable {
    let coins: [Coin]
    let nfts: [Nft]
}

struct Coin: Codable {
    let item: Item
}

struct Item: Codable {
    let id: String
    let coinID: Int
    let name, symbol: String
    let marketCapRank: Int
    let thumb, small, large: String
    let slug: String
    let priceBtc: Double
    let score: Int

    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name, symbol
        case marketCapRank = "market_cap_rank"
        case thumb, small, large, slug
        case priceBtc = "price_btc"
        case score
    }
}

struct Nft: Codable {
    let id, name, symbol: String
    let thumb: String
    let nftContractID: Int

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, thumb
        case nftContractID = "nft_contract_id"
    }
}
