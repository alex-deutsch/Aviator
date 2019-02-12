//
//  LHBestPriceFactory.swift
//  Aviator
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import Foundation
import AirportKit

public class LHBestPriceFactory {

    public init() {}

    public func create() -> LHBestpriceSearchVC {
        let airportInteractor = AirportInteractor()
        let presenter = LHBestPriceSearchPresenter(interactor: LHBestPriceSearchInteractor(airportInteractor: airportInteractor))
        let viewController = LHBestpriceSearchVC(presenter: presenter)
        return viewController
    }
}
