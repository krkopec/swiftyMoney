//
//  CurrencyConverter.swift
//  Money
//
//  Created by Krystian Kopeć on 17/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

public class CurrencyConverter {

    public fileprivate(set) var baseCurrency: Currency
    public fileprivate(set) var currencyExchangeRates: Set<CurrencyExchangeRate>

    public init(currencyExchangeRatePackage: CurrencyExchangeRatePackage) {
        self.baseCurrency = currencyExchangeRatePackage.baseCurrency
        self.currencyExchangeRates = currencyExchangeRatePackage.currencyExchangeRates
    }

    public init(baseCurrency: Currency, targetCurrencyExchangeRates: Set<CurrencyExchangeRate>) {
        self.baseCurrency = baseCurrency
        self.currencyExchangeRates = targetCurrencyExchangeRates
    }

    public func setCurrencyExchangeRates(currencyExchangeRatePackage: CurrencyExchangeRatePackage) {
        self.baseCurrency = currencyExchangeRatePackage.baseCurrency
        self.currencyExchangeRates = currencyExchangeRatePackage.currencyExchangeRates
    }

    public func setCurrencyExchangeRates(baseCurrency: Currency,
                                         targetCurrencyExchangeRates: Set<CurrencyExchangeRate>) {
        self.baseCurrency = baseCurrency
        self.currencyExchangeRates = targetCurrencyExchangeRates
    }

    public func insertCurrencyExchangeRate(baseCurrency: Currency,
                                           targetCurrencyExchangeRates: CurrencyExchangeRate) {

        if baseCurrency == self.baseCurrency {
            self.currencyExchangeRates.insert(targetCurrencyExchangeRates)
        } else {
            print("Could not insert currency exchange rate, because its base currency and converter's base currency are not the same")
        }
    }

    public func convert(money: Money, to currency: Currency) -> Money? {

        guard money.currency != currency else { return money }


        if money.currency == baseCurrency {

            guard let sourceToTargetCurrencyExchangeRate = getBaseToTargetCurrencyExchangeRate(for: currency) else {
                return nil
            }
            return Money(value: money.value * sourceToTargetCurrencyExchangeRate,
                         currency: currency)
        } else {
            guard let sourceToBaseCurrencyExchangeRate = getTargetToBaseCurrencyExchangeRate(for: money.currency) else {
                return nil
            }

            guard let baseToTargetCurrencyExchangeRate = getBaseToTargetCurrencyExchangeRate(for: currency) else {
                return nil
            }

            let faceValue = money.value * sourceToBaseCurrencyExchangeRate * baseToTargetCurrencyExchangeRate

            return Money(value: faceValue,
                         currency: currency)
        }
    }

    public func convertMoneyToBaseCurrency(money: Money) -> Money? {
        return convert(money: money, to: baseCurrency)
    }

    private func getBaseToTargetCurrencyExchangeRate(for currency: Currency) -> Decimal? {

        if currency != baseCurrency {
            guard let baseToTargetCurrencyExchangeRate = currencyExchangeRates.first(where: { $0.targetCurrency == currency })?.baseToTargetCurrencyConversionRate else {

                print("Could not get base-to-target currency exchange rate for currency: \(currency) in currency converter's exchange rates")
                return nil
            }
            return baseToTargetCurrencyExchangeRate
        } else {
            return Decimal(1)
        }
    }

    private func getTargetToBaseCurrencyExchangeRate(for currency: Currency) -> Decimal? {

        if currency != baseCurrency {
            guard let targetToBaseCurrencyExchangeRate = currencyExchangeRates.first(where: { $0.targetCurrency == currency })?.targetToBaseCurrencyConversionRate else {

                print("Could not get target currency exchange rate for currency: \(currency) in currency converter's exchange rates")
                return nil
            }
            return targetToBaseCurrencyExchangeRate
        } else {
            return Decimal(1)
        }
    }
}
