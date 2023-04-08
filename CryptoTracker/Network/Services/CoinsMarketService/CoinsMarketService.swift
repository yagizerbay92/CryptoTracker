//
//  CoinsMarketService.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 31.03.2023.
//

import Foundation

//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=false&locale=en

class CoinsMarketService {
    static let shared = CoinsMarketService()
    private init() {}
    
    private func createUrl() -> URL? {
        let urlQuery: [URLQueryItem] = [URLQueryItem(name: URLBuilderComponents.currencyKey.value, value: "usd"),
                                        URLQueryItem(name: URLBuilderComponents.orderKey.value, value: OrderConstants.marketCapDescending.value),
                                        URLQueryItem(name: URLBuilderComponents.perPageKey.value, value: "5"),
                                        URLQueryItem(name: URLBuilderComponents.pageKey.value, value: "1"),
                                        URLQueryItem(name: URLBuilderComponents.sparklineKey.value, value: false.description),
                                        URLQueryItem(name: URLBuilderComponents.localeKey.value, value: "en")]
        
        return URLBuilder.buildURL(scheme: UrlScheme.https.value,
                                   host: URLBuilderComponents.baseUrl.value,
                                   queries: urlQuery,
                                   path: URLBuilderComponents.markets.value)
    }
}

extension CoinsMarketService {
    func getMarketList(completion: @escaping (Result<[MarketLisItem], Error>) -> Void) {
        guard let url = createUrl() else { return }
        
        NetworkManager.shared.request(dataType: [MarketLisItem].self,
                                      urlString: url,
                                      method: .get) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
