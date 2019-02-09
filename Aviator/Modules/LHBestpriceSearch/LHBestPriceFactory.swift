//
//  LHBestPriceFactory.swift
//  Aviator
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import Foundation

public class LHBestPriceFactory {

    public init() {}

    public func create() -> LHBestpriceSearchVC {
        let presenter = LHBestPriceSearchPresenter(interactor: LHBestPriceSearchInteractor())
        let viewController = LHBestpriceSearchVC(presenter: presenter)
        return viewController
    }
}
