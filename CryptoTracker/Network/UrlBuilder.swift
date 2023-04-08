//
//  UrlBuilder.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 29.03.2023.
//

import Foundation

class URLBuilder {

    // MARK: - Properties
    private var url: String = ""

    // MARK: - Life Cycle
    init(_ url: String) {
        self.url = url
    }

    // MARK: - Builder
    private func build() -> URLComponents? {
        return URLComponents(string: url)
    }

    static func buildURLString(scheme: String, host: String, queries: [URLQueryItem], path: String) -> String {
        guard let url = self.buildURL(scheme: scheme, host: host, queries: queries, path: path) else { return "" }
        return url.absoluteString
    }

    static func buildURL(scheme: String, host: String, queries: [URLQueryItem], path: String) -> URL? {
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = queries
        return URL(string: component.string ?? "")
    }

    // MARK: - Components
    var api: String {
        // https://abc.com/foo
        return "\(scheme)://\(host)\(path)"
    }

    var scheme: String {
        return build()?.scheme ?? ""
    }

    var host: String {
        return build()?.host ?? ""
    }

    var path: String {
        return build()?.path ?? ""
    }

    var query: String {
        return build()?.query ?? ""
    }

    var queryItems: [URLQueryItem] {
        return build()?.queryItems ?? [URLQueryItem]()
    }

    var queryNames: [String] {
        return queryItems.map { $0.name }
    }

    var queryValues: [String] {
        return queryItems.map { $0.value ?? "" }
    }
}
