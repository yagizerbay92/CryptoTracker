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
    public var isPaginating = false
    private init() {}
    
    private func createUrl(paginationValue: Int) -> URL? {
        let urlQuery: [URLQueryItem] = [URLQueryItem(name: URLBuilderComponents.currencyKey.value, value: "usd"),
                                        URLQueryItem(name: URLBuilderComponents.orderKey.value, value: OrderConstants.marketCapDescending.value),
                                        URLQueryItem(name: URLBuilderComponents.perPageKey.value, value: "10"),
                                        URLQueryItem(name: URLBuilderComponents.pageKey.value, value: paginationValue.description),
                                        URLQueryItem(name: URLBuilderComponents.sparklineKey.value, value: false.description),
                                        URLQueryItem(name: URLBuilderComponents.localeKey.value, value: "en")]
        
        return URLBuilder.buildURL(scheme: UrlScheme.https.value,
                                   host: URLBuilderComponents.baseUrl.value,
                                   queries: urlQuery,
                                   path: URLBuilderComponents.markets.value)
    }
}

extension CoinsMarketService {
    func getMarketList(pagination: Bool = false,
                       paginationValue: Int,
                       completion: @escaping (Result<[MarketLisItem], Error>) -> Void) {
        guard let url = createUrl(paginationValue: paginationValue) else { return }
        if pagination {
            self.isPaginating = true
        }
        
        NetworkManager.shared.request(dataType: [MarketLisItem].self,
                                      urlString: url,
                                      method: .get) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
                if pagination {
                    self.isPaginating = false
                }
            case .failure(let failure):
                completion(.failure(failure))
                if pagination {
                    self.isPaginating = false
                }
            }
        }
    }
}
