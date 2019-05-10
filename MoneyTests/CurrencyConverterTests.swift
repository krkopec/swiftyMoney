//
//  CurrencyConverterTests.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 28/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest
@testable import SwiftyMoney

class CurrencyConverterTests: XCTestCase {

    let euroToPoundRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                               targetCurrency: .poundSterling,
                                               allowsInverseConversion: true,
                                               sourceToTargetRate: 0.87295)

    let euroToUSDollarRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                                  targetCurrency: .usDollar,
                                                  allowsInverseConversion: true,
                                                  sourceToTargetRate: 1.12979)

    let poundToUSDollarRate = CurrencyExchangeRate(sourceCurrency: .poundSterling,
                                                   targetCurrency: .usDollar,
                                                   allowsInverseConversion: true,
                                                   sourceToTargetRate: 1.29422)

    func testConversionWithNilRates() {
        let converter = CurrencyConverter(baseCurrency: .euro,
                                          currencyExchangeRates: [])
        let twoPounds = Money(value: 2, currency: .poundSterling)
        let twoPoundsInDollars = converter.convert(money: twoPounds, to: .usDollar)
        XCTAssert (twoPoundsInDollars == nil)
    }

    func testDirectConversionFromSourceToTargetCurrency() {

        let converter = CurrencyConverter(currencyExchangeRates: [euroToUSDollarRate])

        let twoEuroAndChange = Money(value: 2.13, currency: .euro)
        guard let twoEuroAndChangeInUSDollars = converter.convert(money: twoEuroAndChange,
                                                                  to: .usDollar) else {
            XCTAssert(false); return
        }
        print(twoEuroAndChangeInUSDollars)
        XCTAssert (twoEuroAndChangeInUSDollars == Money(value: 2.41, currency: .usDollar))
    }

    func testDirectInverseConversionFromSourceToTargetCurrency() {

        let converter = CurrencyConverter(currencyExchangeRates: [euroToUSDollarRate])

        let twoDollarsAndChange = Money(value: 2.41, currency: .usDollar)
        guard let twoDollarsAndChangeInEuro = converter.convert(money: twoDollarsAndChange,
                                                                to: .euro) else {
            XCTAssert(false); return
        }
        XCTAssert (twoDollarsAndChangeInEuro == Money(value: 2.13, currency: .euro))
    }

    func testDirectToAndBackConversion() {
        let converter = CurrencyConverter(currencyExchangeRates: [euroToUSDollarRate])

        let twoEuro = Money(value: 2, currency: .euro)
        guard let twoEuroInUSDollars = converter.convert(money: twoEuro,
                                                         to: .usDollar) else {
            XCTAssert(false); return
        }

        guard let twoEuroBackConversionValue = converter.convert(money: twoEuroInUSDollars,
                                                                 to: .euro) else {
            XCTAssert(false); return
        }
        XCTAssert (twoEuroBackConversionValue.value == 2)
    }

    func testConversionFromBaseCurrencyToBaseCurrency() {
        let converter = CurrencyConverter(baseCurrency: .euro,
                                          currencyExchangeRates: [euroToUSDollarRate])
        let twoEuroAndChange = Money(value: 2.13, currency: .euro)
        guard let convertedTwoEuroAndChange = converter.convertMoneyToBaseCurrency(money: twoEuroAndChange) else {
            XCTAssert(false); return
        }
        XCTAssert (convertedTwoEuroAndChange == twoEuroAndChange)
    }

    func testConversionFromCurrencyToBaseCurrency() {
        let converter = CurrencyConverter(baseCurrency: .euro,
                                          currencyExchangeRates: [euroToUSDollarRate])
        let twoDollarsAndChange = Money(value: 2.26, currency: .usDollar)
        guard let twoDollarsAndChangeInEuro = converter.convertMoneyToBaseCurrency(money: twoDollarsAndChange) else {
            XCTAssert(false); return
        }
        XCTAssert (twoDollarsAndChangeInEuro == Money(value: 2, currency: .euro))
    }

    func testConversionFromCurrencyToSameCurrency() {
        let converter = CurrencyConverter(baseCurrency: nil,
                                          currencyExchangeRates: [euroToUSDollarRate])
        let twoEuroAndChange = Money(value: 2.13, currency: .euro)
        guard let convertedTwoEuroAndChange = converter.convert(money: twoEuroAndChange,
                                                                to: .euro)
            else {
            XCTAssert(false); return
        }
        XCTAssert (convertedTwoEuroAndChange == twoEuroAndChange)
    }

    func testIndirectConversionFromCurrencyToAnotherCurrency() {
        let converter = CurrencyConverter(baseCurrency: .euro,
                                          currencyExchangeRates: [euroToUSDollarRate,
                                                                  euroToPoundRate])
        let twoPounds = Money(value: 2, currency: .poundSterling)
        let twoPoundsInDollars = converter.convert(money: twoPounds, to: .usDollar)
        XCTAssert ( twoPoundsInDollars == Money(value: 2.59,
                                                currency: .usDollar))
    }

    func testDirectConversionFromCurrencyToAnotherCurrencyWithDifferentBase() {
        let converter = CurrencyConverter(baseCurrency: .euro,
                                          currencyExchangeRates: [poundToUSDollarRate])
        let twoPounds = Money(value: 2, currency: .poundSterling)
        let twoPoundsInDollars = converter.convert(money: twoPounds, to: .usDollar)
        XCTAssert ( twoPoundsInDollars == Money(value: 2.59,
                                                currency: .usDollar))
    }
}
