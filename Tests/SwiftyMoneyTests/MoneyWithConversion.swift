//
//  MoneyWithConversion.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 02/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest
@testable import SwiftyMoney

class MoneyWithConversion: XCTestCase {

    var euroToPoundRate: CurrencyExchangeRate!
    var euroToUSDollarRate: CurrencyExchangeRate!
    var poundToUSDollarRate: CurrencyExchangeRate!
    var euroToKronaRate: CurrencyExchangeRate!
    var euroToDongRate: CurrencyExchangeRate!

    var euro: Currency!
    var poundSterling: Currency!
    var usDollar: Currency!
    var swedishKrona: Currency!
    var vietnameseDong: Currency!

    override func setUp() {

        euro = Currencies.getCurrency(withCurrencyCode: "EUR")!
        poundSterling = Currencies.getCurrencies(forCountryCode: "UK").first!
        usDollar = Currencies.getCurrency(withCurrencyCode: "USD")!
        swedishKrona = Currencies.getCurrency(withCurrencyCode: "SEK")!
        vietnameseDong = Currencies.getCurrency(withCurrencyCode: "VND")!

        euroToPoundRate = CurrencyExchangeRate(sourceCurrency: euro,
                                               targetCurrency: poundSterling, allowsInverseConversion: true,
                                               sourceToTargetRate: 0.87295)

        euroToUSDollarRate = CurrencyExchangeRate(sourceCurrency: euro,
                                                  targetCurrency: usDollar,
                                                  allowsInverseConversion: true,
                                                  sourceToTargetRate: 1.12979)

        poundToUSDollarRate = CurrencyExchangeRate(sourceCurrency: poundSterling,
                                                   targetCurrency: usDollar,
                                                   allowsInverseConversion: true,
                                                   sourceToTargetRate: 1.29422)

        euroToKronaRate = CurrencyExchangeRate(sourceCurrency: euro,
                                               targetCurrency: swedishKrona,
                                               allowsInverseConversion: true,
                                               sourceToTargetRate: 10.7405)

        euroToDongRate = CurrencyExchangeRate(sourceCurrency: euro,
                                               targetCurrency: vietnameseDong,
                                               allowsInverseConversion: true,
                                               sourceToTargetRate: 26161.32)
    }

    func testSameCurrencyAdditionWithDifferentCurrencies() {

        Money.setCurrencyConverter(to: CurrencyConverter(baseCurrency: euro,
                                                         currencyExchangeRates: [euroToUSDollarRate]))

        let tenEuro = Money(value: 10, currency: euro)
        let tenDollars = Money(value: 10, currency: usDollar)
        let tenDollarsInEuro = 10 * (1 / 1.12979)
        XCTAssertTrue(tenEuro + tenDollars == Money(value: 10 + tenDollarsInEuro,
                                                    currency: euro) )
        Money.setCurrencyConverter(to: nil)
    }

    func testMoneyConvertedToBaseCurrency() {

        Money.setCurrencyConverter(to: CurrencyConverter(baseCurrency: euro,
                                                         currencyExchangeRates: [euroToUSDollarRate]))

        let twoDollarsAndChange = Money(value: 2.40, currency: usDollar)
        let twoDollarsAndChangeInEuro =  twoDollarsAndChange.convertedToBaseCurrency()

        XCTAssert ( twoDollarsAndChangeInEuro == Money(value: 2.12,
                                                       currency: euro))
        Money.setCurrencyConverter(to: nil)
    }

    func testCurrencyConversionWithoutBaseCurrency() {

        Money.setCurrencyConverter(to: CurrencyConverter(currencyExchangeRates: [poundToUSDollarRate]))

        let twoDollars = Money(value: 2, currency: usDollar)
        let twoDollarsInPounds = twoDollars.converted(to: poundSterling)
        XCTAssert ( twoDollarsInPounds == Money(value: 1.55,
                                                currency: poundSterling))
        Money.setCurrencyConverter(to: nil)
    }

    func testCurrencyConversionToCurrencyWithRoundingScaleZero() {

        Money.setCurrencyConverter(to: CurrencyConverter(currencyExchangeRates: [euroToDongRate]))

        let twoEuros = Money(value: 2, currency: euro)
        let twoEurosInKrona = twoEuros.converted(to: vietnameseDong)
        XCTAssert ( twoEurosInKrona == Money(value: 52322.6,
                                             currency: swedishKrona))
        Money.setCurrencyConverter(to: nil)
    }
}
