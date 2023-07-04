//
//  Router.swift
//  CryptoTracker
//
//  Created by Erbay, Yagiz on 4.07.2023.
//

import Foundation
import UIKit

protocol Router {
    func route(to routeID: Route, from context: UIViewController, parameters: Any?)
}
