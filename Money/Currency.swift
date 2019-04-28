//
//  Currency.swift
//  Money
//
//  Created by Krystian Kopeć on 02/03/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//
//  Contains Currency struct. To make it easier to use various currencies, the Currency struct can be extended with a public static property defining a specific currency.

import Foundation

public struct Currency {
    public let name: String
    public let code: String
    public let unitSymbol: CurrencySymbol
    public let subunitSymbol: CurrencySymbol?
}

extension Currency: Equatable {
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension Currency: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(code)
        hasher.combine(unitSymbol)
        hasher.combine(subunitSymbol)
    }
}
