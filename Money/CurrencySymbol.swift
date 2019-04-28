//
//  CurrencySymbol.swift
//  Money
//
//  Created by Krystian Kopeć on 28/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//
//  Contains CurrencySymbol struct, which specifies what currency symbol is used for a specific currency
//  and whether it should precede or follow the currency amount, e.g. $10 or 10 zł.

import Foundation

public struct CurrencySymbol {
    let symbol: String
    let position: SymbolPosition

    enum SymbolPosition {
        case before, after
    }
}

extension CurrencySymbol: Equatable {
    public static func == (lhs: CurrencySymbol, rhs: CurrencySymbol) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension CurrencySymbol: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
        hasher.combine(position)
    }
}
