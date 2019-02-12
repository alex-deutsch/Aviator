//
//  LHBestPriceSearchPresenter.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import Foundation
import RxSwift
import AirportKit

protocol LHBestPriceSearchPresenterProtocol {
    func getBestPrices(from fromAirports: [Airport], to toAirports: [Airport])
    var departureAirports: [Airport] { get }
    var destinationAirports: [Airport] { get }
    var viewModelsObserver: Observable<[LHBestPriceResultViewModel]> { get }
}

class LHBestPriceSearchPresenter {
    private let interactor: LHBestPriceSearchInteractorProtocol
    private let disposeBag = DisposeBag()

    private var viewModels: Variable<[LHBestPriceResultViewModel]> = Variable([])

    init(interactor: LHBestPriceSearchInteractorProtocol) {
        self.interactor = interactor
    }
}

extension LHBestPriceSearchPresenter: LHBestPriceSearchPresenterProtocol {
    func getBestPrices(from fromAirports: [Airport], to toAirports: [Airport]) {
        self.viewModels.value.removeAll()
        
        let today = Date()
        fromAirports.forEach { from in
            toAirports.forEach({ to in
                interactor.getFlights(from: from.code, to: to.code, startDate: today, durationInDays: 7).subscribe{ event in
                    switch event {
                    case .success(let model):
                        var models = self.viewModels.value
                        models.append(contentsOf: model.compactMap({ (model) -> LHBestPriceResultViewModel? in
                            return LHBestPriceResultViewModel(model: model, from: from, to: to)
                        }))
                        models.sort(by: { (left, right) -> Bool in
                            return Float(left.price) ?? 0 < Float(right.price) ?? 0
                        })
                        self.viewModels.value = models
                    case .error(let error):
                        print("Error: ", error)
                    }
                }.disposed(by: disposeBag)
            })
        }
    }

    var viewModelsObserver: Observable<[LHBestPriceResultViewModel]> {
        return viewModels.asObservable()
    }

    var departureAirports: [Airport] {
        return interactor.airports.filter({ $0.tz == "Europe" && $0.isMajor })
    }

    var destinationAirports: [Airport] {
        return interactor.airports.filter({ $0.tz == "Asia" && $0.isMajor })
    }
}
