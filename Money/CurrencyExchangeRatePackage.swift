//
//  CurrencyRate.swift
//  Money
//
//  Created by Krystian Kopeć on 17/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//
//  Contains a set of currency exchanges rates, consisting of a baseCurrency, i.e. the currency that all the rates are calculated from, and target currency exchange rates, each consisting of a target currency and its target conversion rate.

import Foundation

// MARK: CurrencyExchangeRatePackage
public struct CurrencyExchangeRatePackage {

    let createdAt: Date?
    // should be equal to conversionRate times targetCurrency
    let baseCurrency: Currency
    let currencyExchangeRates: Set<CurrencyExchangeRate>
}

extension CurrencyExchangeRatePackage: Equatable {
    public static func == (lhs: CurrencyExchangeRatePackage, rhs: CurrencyExchangeRatePackage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension CurrencyExchangeRatePackage: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(createdAt)
        hasher.combine(baseCurrency)
        hasher.combine(currencyExchangeRates)
    }
}
