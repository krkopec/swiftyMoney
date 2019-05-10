//
//  MoneyWithConversion.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 02/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest

class MoneyWithConversion: XCTestCase {

    let euroToPoundRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                               targetCurrency: .poundSterling, allowsInverseConversion: true,
                                               sourceToTargetRate: 0.87295)

    let euroToUSDollarRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                                  targetCurrency: .usDollar,
                                                  allowsInverseConversion: true,
                                                  sourceToTargetRate: 1.12979)

    let poundToUSDollarRate = CurrencyExchangeRate(sourceCurrency: .poundSterling,
                                                   targetCurrency: .usDollar,
                                                   allowsInverseConversion: true,
                                                   sourceToTargetRate: 1.29422)

    let euroToKronaRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                               targetCurrency: .swedishKrona,
                                               allowsInverseConversion: true,
                                               sourceToTargetRate: 10.7405)

    func testSameCurrencyAdditionWithDifferentCurrencies() {

        Money.setCurrencyConverter(to: CurrencyConverter(baseCurrency: .euro,
                                                         currencyExchangeRates: [euroToUSDollarRate]))

        let tenEuro = Money(value: 10, currency: .euro)
        let tenDollars = Money(value: 10, currency: .usDollar)
        let tenDollarsInEuro = 10 * (1 / 1.12979)
        XCTAssertTrue(tenEuro + tenDollars == Money(value: 10 + tenDollarsInEuro,
                                                    currency: .euro) )
        Money.setCurrencyConverter(to: nil)
    }

    func testMoneyConvertedToBaseCurrency() {

        Money.setCurrencyConverter(to: CurrencyConverter(baseCurrency: .euro,
                                                         currencyExchangeRates: [euroToUSDollarRate]))

        let twoDollarsAndChange = Money(value: 2.40, currency: .usDollar)
        let twoDollarsAndChangeInEuro =  twoDollarsAndChange.convertedToBaseCurrency()

        XCTAssert ( twoDollarsAndChangeInEuro == Money(value: 2.12,
                                                       currency: .euro))
        Money.setCurrencyConverter(to: nil)
    }

    func testCurrencyConversionWithoutBaseCurrency() {

        Money.setCurrencyConverter(to: CurrencyConverter(currencyExchangeRates: [poundToUSDollarRate]))

        let twoDollars = Money(value: 2, currency: .usDollar)
        let twoDollarsInPounds = twoDollars.converted(to: .poundSterling)
        XCTAssert ( twoDollarsInPounds == Money(value: 1.55,
                                                currency: .poundSterling))
        Money.setCurrencyConverter(to: nil)
    }

    func testCurrencyConversionToCurrencyWithRoundingScaleZero() {

        Money.setCurrencyConverter(to: CurrencyConverter(currencyExchangeRates: [euroToKronaRate]))

        let twoEuros = Money(value: 2, currency: .euro)
        let twoEurosInKrona = twoEuros.converted(to: .swedishKrona)
        XCTAssert ( twoEurosInKrona == Money(value: 21,
                                             currency: .swedishKrona))
        Money.setCurrencyConverter(to: nil)
    }
}
