//
//  CurrencyConverter.swift
//  Money
//
//  Created by Krystian Kopeć on 17/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//
//  Contains CurrencyConverter class used to convert money to other currencies.
//  The class may convert currencies directly (e.g. from PLN to USD) by using appropriate
//  currency exchange rate pairs contained in the currencyExchangeRates property or indirectly
//  (e.g. from PLN to baseCurrency (e.g. EUR) and then to USD) by using currencyExchangeRates
//  property combined with the optional baseCurrency property, which serves as an intermediate
//  step to simplify conversion and decrease the number of currency exchange rate combinations
//  needed to convert between multiple currencies.

import Foundation

/// A class that enables performing conversion between different currencies
public class CurrencyConverter {

    /// An optional property used for indirect currency conversion.
    public fileprivate(set) var baseCurrency: Currency?

    /// A property used for direct and indirect currency conversion.
    public fileprivate(set) var currencyExchangeRates: Set<CurrencyExchangeRate>

    public init(baseCurrency: Currency? = nil,
                currencyExchangeRates: Set<CurrencyExchangeRate>) {
        self.baseCurrency = baseCurrency
        self.currencyExchangeRates = currencyExchangeRates
    }

    public func set(currencyExchangeRates: Set<CurrencyExchangeRate>) {
        self.currencyExchangeRates = currencyExchangeRates
    }

    public func set(baseCurrency: Currency?) {
        self.baseCurrency = baseCurrency
    }

    public func insert(currencyExchangeRate: CurrencyExchangeRate) {
        self.currencyExchangeRates.insert(currencyExchangeRate)
    }

    public func convert(money: Money, to currency: Currency) -> Money? {

        guard money.currency != currency else {
            return money
        }

        if currencyExchangeRates.contains(where: {
            $0.targetCurrency == currency && $0.sourceCurrency == money.currency }) {

            // performs conversion if corresponding currency exchange rates are found
            guard let sourceToTargetRate = currencyExchangeRates.filter({
                $0.sourceCurrency == money.currency &&
                    $0.targetCurrency == currency }).first?.sourceToTargetRate
                else { return nil }

            return Money(value: money.value * sourceToTargetRate,
                         currency: currency)

        } else if currencyExchangeRates.contains(where: {
            $0.sourceCurrency == currency && $0.targetCurrency == money.currency }) {

            // performs conversion if corresponding inversed currency exchange rates are found
            guard let targetToSourceRate = currencyExchangeRates.filter({
                $0.targetCurrency == money.currency &&
                    $0.sourceCurrency == currency }).first?.targetToSourceRate
                else { return nil }

            return Money(value: money.value * targetToSourceRate,
                         currency: currency)

            // otherwise baseCurrency is used for conversion as an intermediate step
        } else {

            if let baseCurrency = baseCurrency {

                // converts baseCurrency to target currency
                if money.currency == baseCurrency {

                    guard let sourceToTargetCurrencyExchangeRate = getBaseToTargetCurrencyExchangeRate(for: currency) else {
                        return nil
                    }
                    return Money(value: money.value * sourceToTargetCurrencyExchangeRate,
                                 currency: currency)

                    // converts source currency to baseCurrency and then to target currency
                } else {
                    guard let sourceToBaseCurrencyExchangeRate = getTargetToBaseCurrencyExchangeRate(for: money.currency) else {
                        return nil
                    }

                    guard let baseToTargetCurrencyExchangeRate = getBaseToTargetCurrencyExchangeRate(for: currency) else {
                        return nil
                    }

                    let targetValue = money.value * sourceToBaseCurrencyExchangeRate * baseToTargetCurrencyExchangeRate

                    return Money(value: targetValue,
                                 currency: currency)
                }
            } else {
                print("Conversion could not be performed from \(money.currency.name) to \(currency.name), because currency converter's base currency is nil and/or no matching currency exchange rates could be found")
                return nil
            }
        }
    }

    public func convertMoneyToBaseCurrency(money: Money) -> Money? {
        guard let baseCurrency = baseCurrency else {
            print("Could not convert to an amount in base currency, because converter's base currency is nil; please set currency converter's base currency")
            return nil
        }
        return convert(money: money, to: baseCurrency)
    }

    private func getBaseToTargetCurrencyExchangeRate(for currency: Currency) -> Decimal? {

        guard let baseCurrency = self.baseCurrency else {
            print("Could not get currency converter's base currency, because it is nil; please set currency converter's base currency")
            return nil
        }

        if currency != baseCurrency {

            guard let baseToTargetRate = currencyExchangeRates.filter({
                $0.targetCurrency == currency &&
                    $0.sourceCurrency == baseCurrency }).first?.sourceToTargetRate

                else {
                    print("Could not get base-to-target currency exchange rate for currency: \(currency) in currency converter's exchange rates")
                    return nil
            }
            return baseToTargetRate
        } else {
            return Decimal(1)
        }
    }

    private func getTargetToBaseCurrencyExchangeRate(for currency: Currency) -> Decimal? {

        guard let baseCurrency = baseCurrency else {
            print("Could not get currency converter's base currency, because it is nil; please set currency converter's base currency")
            return nil
        }

        if currency != baseCurrency {

            guard let targetToBaseRate = currencyExchangeRates.filter({
                $0.targetCurrency == currency &&
                    $0.sourceCurrency == baseCurrency }).first?.targetToSourceRate

                else {
                    print("Could not get target currency exchange rate for currency: \(currency) in currency converter's exchange rates")
                    return nil
            }
            return targetToBaseRate
        } else {
            return Decimal(1)
        }
    }
}
