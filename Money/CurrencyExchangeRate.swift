//
//  CurrencyExchangeRate.swift
//  Money
//
//  Created by Krystian Kopeć on 28/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

/// A struct representing a currency exchange rate.
public struct CurrencyExchangeRate {

    let sourceCurrency: Currency
    let targetCurrency: Currency

    /// specifies sourceCurrency-to-targetCurrency conversion rate
    let sourceToTargetRate: Decimal

    var targetToSourceRate: Decimal {
        return 1 / sourceToTargetRate
    }
}

extension CurrencyExchangeRate: Equatable {
    public static func == (lhs: CurrencyExchangeRate, rhs: CurrencyExchangeRate) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension CurrencyExchangeRate: Comparable {
    public static func < (lhs: CurrencyExchangeRate, rhs: CurrencyExchangeRate) -> Bool {
        return lhs.sourceToTargetRate < rhs.sourceToTargetRate
    }
}

extension CurrencyExchangeRate: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sourceCurrency)
        hasher.combine(targetCurrency)
        hasher.combine(sourceToTargetRate)
    }
}
