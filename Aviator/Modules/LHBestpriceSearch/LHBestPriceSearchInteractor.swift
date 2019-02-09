//
//  LHBestPriceSearchInteractor.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import RxAlamofire
import RxSwift
import Alamofire
import F1reKit

protocol LHBestPriceSearchInteractorProtocol {
    func getFlights(from airportCodeFrom: String, to airportCodeTo: String, startDate: Date, durationInDays: Int) -> Single<[LHBestPriceResult]>
}

class LHBestPriceSearchInteractor {

    private let disposeBag = DisposeBag()
}

extension LHBestPriceSearchInteractor: LHBestPriceSearchInteractorProtocol {
    func getFlights(from airportCodeFrom: String, to airportCodeTo: String, startDate: Date, durationInDays: Int) -> Single<[LHBestPriceResult]> {
        return Single<[LHBestPriceResult]>.create { observer in
            let request = BestPriceRequest(sortType: .flightsByMonth,
                                               from: airportCodeFrom,
                                               to: airportCodeTo,
                                               date: startDate,
                                               durationInDays: durationInDays,
                                               cabintype: .Business)
            return json(request: request)
                .observeOn(MainScheduler.instance)
                .subscribe { json in
                    guard let result = json.element as? [String: Any] else { return }
                    guard let dates = result["dates"] as? [String: [String: Any]] else { return }
                    guard let results = try? dates.mapValues({ value -> LHBestPriceResult? in
                        let data = try JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.sortedKeys)
                        return try? JSONDecoder().decode(LHBestPriceResult.self, from: data)
                    }).compactMap({ $0.value })
                        else {
                            observer(.error(RequestError.mappingFailed))
                            return
                    }
                    observer(.success(results))
            }
        }
    }
}
