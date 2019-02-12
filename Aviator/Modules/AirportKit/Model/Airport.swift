//
//  Airport.swift
//  Aviator
//
//  Created by Alexander Deutsch on 09.02.19.
//  Copyright © 2019 Alexander Deutsch. All rights reserved.
//

import Foundation

public struct Airport: Codable {
   public let code: String
   public let lat: String
   public let lon: String
   public let name: String
   public let city: String
   public let state: String?
   public let country: String
   public let woeid: String
   public let tz: String
   public let phone: String
   public let type: String
   public let email: String
   public let url: String
   public let elev: String?
   public let icao: String?
   public let carriers: String?
}

extension Airport: Comparable {
    public static func < (lhs: Airport, rhs: Airport) -> Bool {
        return lhs.name == rhs.name &&
            lhs.code == rhs.code
    }

    public var isMajor: Bool {
        return Int(carriers ?? "0") ?? 0 > 20
    }
}
