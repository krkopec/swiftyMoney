//
//  CurrencyExchangeRate.swift
//  Money
//
//  Created by Krystian Kopeć on 28/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

// MARK: TargetCurrencyExchangeRate
public struct CurrencyExchangeRate {

    var targetToBaseCurrencyConversionRate: Decimal {
        return 1 / baseToTargetCurrencyConversionRate
    }

    let baseToTargetCurrencyConversionRate: Decimal
    let targetCurrency: Currency
}

extension CurrencyExchangeRate: Equatable {
    public static func == (lhs: CurrencyExchangeRate, rhs: CurrencyExchangeRate) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension CurrencyExchangeRate: Comparable {
    public static func < (lhs: CurrencyExchangeRate, rhs: CurrencyExchangeRate) -> Bool {
        return lhs.baseToTargetCurrencyConversionRate < rhs.baseToTargetCurrencyConversionRate
    }
}

extension CurrencyExchangeRate: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(targetCurrency)
        hasher.combine(baseToTargetCurrencyConversionRate)
    }
}
