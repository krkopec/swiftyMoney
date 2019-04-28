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
    public fileprivate(set) var targetCurrencyExchangeRates: Set<TargetCurrencyExchangeRate>

    public init(currencyExchangeRatePackage: CurrencyExchangeRatePackage) {
        self.baseCurrency = currencyExchangeRatePackage.baseCurrency
        self.targetCurrencyExchangeRates = currencyExchangeRatePackage.targetCurrencyExchangeRates
    }

    public init(baseCurrency: Currency, targetCurrencyExchangeRates: Set<TargetCurrencyExchangeRate>) {
        self.baseCurrency = baseCurrency
        self.targetCurrencyExchangeRates = targetCurrencyExchangeRates
    }

    public func setCurrencyExchangeRates(currencyExchangeRatePackage: CurrencyExchangeRatePackage) {
        self.baseCurrency = currencyExchangeRatePackage.baseCurrency
        self.targetCurrencyExchangeRates = currencyExchangeRatePackage.targetCurrencyExchangeRates
    }

    public func setCurrencyExchangeRates(baseCurrency: Currency,
                                         targetCurrencyExchangeRates: Set<TargetCurrencyExchangeRate>) {
        self.baseCurrency = baseCurrency
        self.targetCurrencyExchangeRates = targetCurrencyExchangeRates
    }

    public func insertCurrencyExchangeRate(baseCurrency: Currency,
                                           targetCurrencyExchangeRates: TargetCurrencyExchangeRate) {

        if baseCurrency == self.baseCurrency {
            self.targetCurrencyExchangeRates.insert(targetCurrencyExchangeRates)
        } else {
            print("Could not insert currency exchange rate, because base currencies are not the same")
        }
    }

    public func getCurrencyExchangeRate(for currency: Currency) -> Decimal? {
        return targetCurrencyExchangeRates.first(where: { $0.targetCurrency == currency })?.conversionRate
    }

    public func convert(money: Money, to targetCurrency: Currency) -> Money? {

        guard let moneyValueInBaseCurrency = getBaseCurrencyValue(for: money) else {
            print("Could not convert money \(money) to base currency \(String(describing: baseCurrency))")
            return nil
        }

        guard let targetCurrencyExRate = getCurrencyExchangeRate(for: targetCurrency) else {
            print("Could not get target currency exchange rate for currency \(String(describing: targetCurrency))")
            return nil
        }

        let faceValue = NSDecimalNumber(decimal: moneyValueInBaseCurrency * targetCurrencyExRate)

        return Money(value: faceValue.rounding(accordingToBehavior: Money.decimalHandler) as Decimal,
                     currency: targetCurrency)
    }

    public func convertMoneyToBaseCurrency(money: Money) -> Money? {

        if money.currency == baseCurrency {
            return money
        }

        guard let targetConversionRate = getCurrencyExchangeRate(for: money.currency) else {
            print("Could not get money \(money) to base currency \(String(describing: baseCurrency))")
            return nil
        }
        return Money(value: money.value / targetConversionRate,
                     currency: baseCurrency)
    }

    public func getBaseCurrencyValue(for money: Money) -> Decimal? {

        guard let targetConversionRate = getCurrencyExchangeRate(for: money.currency) else {
            print("Could not get money \(money) to base currency \(String(describing: baseCurrency))")
            return nil
        }
        let valueInBaseCurrency = money.value / targetConversionRate
        return valueInBaseCurrency
    }
}
