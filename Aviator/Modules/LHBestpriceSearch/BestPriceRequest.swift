//
//  BestPriceRequest.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import Alamofire
import F1reKit

struct BestPriceRequest: RequestProtocol {
    private static let baseURLString: String = "https://bestprice-live-backend.mcon.net"

    enum SortType {
        case flightsByMonth

        var path: String {
            switch self {
            case .flightsByMonth:
                return "/flights-by-month"
            }
        }
    }

    enum CabinType: String {
        case Business
        case Economy
        case First
    }

    let url: URLConvertible
    let parameters: [String : Any]?
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let encoding: ParameterEncoding

    init(sortType: SortType, from: String, to: String, date: Date, durationInDays: Int, cabintype: CabinType) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        self.url = BestPriceRequest.baseURLString + sortType.path

        self.parameters = ["l": "de_de",
                           "departure": from,
                           "destination": to,
                           "departureFrom": dateFormatter.string(from: date),
                           "cabin": cabintype.rawValue,
                           "duration": durationInDays
        ]
        self.method = .get
        self.headers = nil
        self.encoding = URLEncoding.default
    }
}
