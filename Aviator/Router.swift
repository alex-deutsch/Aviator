//
//  Router.swift
//  Aviator
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import UIKit
import LHBestpriceSearch

protocol RouterProtocol {
    func presentLufthansaBestPriceSearch(in window: UIWindow)
}

class Router: RouterProtocol {
    func presentLufthansaBestPriceSearch(in window: UIWindow) {
        window.makeKeyAndVisible()
        let viewController = LHBestPriceFactory().create()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}
