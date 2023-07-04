//
//  Constants.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 31.03.2023.
//

import Foundation


//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=false&locale=en

public enum URLBuilderComponents {
    case baseUrl
    case markets
    case currencyKey
    case orderKey
    case perPageKey
    case pageKey
    case sparklineKey
    case localeKey
    
    
    public var value: String {
        switch self {
        case .baseUrl:
            return "api.coingecko.com"
        case .markets:
            return "/api/v3/coins/markets"
        case .currencyKey:
            return "vs_currency"
        case .orderKey:
            return "order"
        case .perPageKey:
            return "per_page"
        case .pageKey:
            return "page"
        case .sparklineKey:
            return "sparkline"
        case .localeKey:
            return "locale"
        }
    }
}

public enum UrlScheme {
    case https
    
    public var value: String {
        switch self {
        case .https:
            return "https"
        }
    }
}

public enum CurrencyConstants {
    case usd
    case eur
    
    public var value: String {
        switch self {
        case .usd:
            return "usd"
        case .eur:
            return "eur"
        }
    }
}

//market_cap_asc, market_cap_desc, volume_asc, volume_desc, id_asc, id_desc
public enum OrderConstants {
    case marketCapAscending
    case marketCapDescending
    case volumeAscending
    case volumeDescendng
    case idAscending
    case idDescending
    
    public var value: String {
        switch self {
        case .marketCapAscending:
            return "market_cap_asc"
        case .marketCapDescending:
            return "market_cap_desc"
        case .volumeAscending:
            return "volumeAscending"
        case  .volumeDescendng:
            return "volume_desc"
        case .idAscending:
            return "id_asc"
        case .idDescending:
            return "id_desc"
        }
    }
}

public enum CellIdentifiers {
    case marketListCellIdentifier
    
    public var value: String {
        switch self {
        case .marketListCellIdentifier:
            return "CoinMarketListTableViewCell"
        }
    }
}

public enum Route {
    case marketItemDetail
}
