//
//  CoinsMarketTrendsService.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 5.07.2023.
//

import Foundation

//https://api.coingecko.com/api/v3/search/trending

class CoinsMarketTrendsService {
    static let shared = CoinsMarketTrendsService()
    private init() {}
    
    private func createUrl() -> URL? {
        let urlQuery: [URLQueryItem] = []
        
        return URLBuilder.buildURL(scheme: UrlScheme.https.value,
                                   host: URLBuilderComponents.baseUrl.value,
                                   queries: urlQuery,
                                   path: URLBuilderComponents.marketTrends.value)
    }
}

extension CoinsMarketTrendsService {
    func getMarketList(completion: @escaping (Result<TrendLists, Error>) -> Void) {
        guard let url = createUrl() else { return }
        
        NetworkManager.shared.marketTrendRequest(dataType: TrendLists.self,
                                                 urlString: url,
                                                 method: .get) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
