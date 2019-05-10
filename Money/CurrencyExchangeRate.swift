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

    /// A property representing the currency that conversion calculations are performed from
    let sourceCurrency: Currency

    /// A property representing the currency that conversion calculations are performed to
    let targetCurrency: Currency

    /// A property specifying whether targetToSourceRate may be calculated as an inverse of sourceToTargetRate
    let allowsInverseConversion: Bool

    /// A property representing sourceCurrency-to-targetCurrency conversion rate
    let sourceToTargetRate: Decimal

    /// A computed property that provides inverse targetCurrency-to-sourceCurrency conversion rate, if allowed
    var targetToSourceRate: Decimal? {
        if allowsInverseConversion {
            return 1 / sourceToTargetRate
        } else {
            return nil
        }
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
        hasher.combine(allowsInverseConversion)
        hasher.combine(sourceToTargetRate)
    }
}
