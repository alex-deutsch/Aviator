//
//  LHBestPriceResultViewModel.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import Foundation
import AirportKit

struct LHBestPriceResultViewModel {
    let fromTo: String
    let price: String
    let currency: String
    let dateString: String
    let linkURLString: String

    init(model: LHBestPriceResult, from: Airport, to: Airport) {
        self.fromTo = "\(from.code) ✈ \(to.code)"
        self.price = "\(model.price)"
        self.dateString = "📅 \(model.departureDate)"
        self.linkURLString = model.deepLinkM
        self.currency = model.currency
    }
}
