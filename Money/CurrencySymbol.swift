//
//  CurrencySymbol.swift
//  Money
//
//  Created by Krystian Kopeć on 28/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//


import Foundation

/// A struct that represents a currency symbol and specifies its position in relation to a money amount provided in this currency
public struct CurrencySymbol {

    /// Specifies a symbol used by a currency, e.g. € or $
    let symbol: String

    /// Specifies whether the symbol precedes or follows the currency amount, e.g. $10 or 10zł
    let precedesAmount: Bool
}

extension CurrencySymbol: Equatable {
    public static func == (lhs: CurrencySymbol, rhs: CurrencySymbol) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension CurrencySymbol: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
        hasher.combine(precedesAmount)
    }
}
