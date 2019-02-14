//
//  AirportInteractor.swift
//  Aviator
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import Foundation

public protocol AirportInteractorProtocol {
    var all: [Airport] { get }
}

public class AirportInteractor: AirportInteractorProtocol {

    public init() {
    }

    public var all: [Airport] {
        guard let url = Bundle(for: type(of: self)).url(forResource: "airports", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let airports = try? JSONDecoder().decode([Airport].self, from: data)
            else { return [] }
        return airports.filter{ $0.name != "" }.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.name < rhs.name
        })
    }
}
