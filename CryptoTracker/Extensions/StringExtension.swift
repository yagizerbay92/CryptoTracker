//
//  StringExtension.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 18.04.2023.
//

import Foundation

extension String {
    func dolarSignAppended() -> String {
        return "$" + self
    }
    
    func minusSignAppended() -> String {
        return "-" + self
    }
    
    func plusSignAppended() -> String {
        return "+" + self
    }
    
    func percentageSignAppended() -> String {
        return self + "%"
    }
}
