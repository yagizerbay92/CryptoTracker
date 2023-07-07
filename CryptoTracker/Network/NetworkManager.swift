//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 22.03.2023.
//

import Foundation
import Alamofire

final class NetworkManager {
    public static let shared = NetworkManager()
    private init() {}
}

extension NetworkManager {
    func request<T: Codable>(dataType: [T].Type,
                             urlString: URL,
                             method: HTTPMethod,
                             completion: @escaping (Result<[T], Error>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: method.rawValue)
        AF.request(urlString, method: method).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let objectResponse = try JSONDecoder().decode(dataType, from: data)
                    completion(.success(objectResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func marketTrendRequest<T: Codable>(dataType: T.Type,
                             urlString: URL,
                             method: HTTPMethod,
                             completion: @escaping (Result<T, Error>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: method.rawValue)
        AF.request(urlString, method: method).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let objectResponse = try JSONDecoder().decode(dataType, from: data)
                    completion(.success(objectResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
