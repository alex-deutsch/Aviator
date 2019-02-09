//
//  LHBestPriceSearchPresenter.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import Foundation
import RxSwift

protocol LHBestPriceSearchPresenterProtocol {
    func getBestPrices(from fromAirports: [String], to toAirports: [String])
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
    func getBestPrices(from fromAirports: [String], to toAirports: [String]) {
        let today = Date()
        fromAirports.forEach { from in
            toAirports.forEach({ to in
                interactor.getFlights(from: from, to: to, startDate: today, durationInDays: 7).subscribe{ event in
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
}
