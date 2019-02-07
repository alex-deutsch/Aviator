//
//  LHBestPriceResult.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import Foundation

struct LHBestPriceResult: Decodable {
    let departureDate: String
    let returnDate: String
    let price: Float
    let currency: String
    let deepLink: String
    let deepLinkM: String
}
