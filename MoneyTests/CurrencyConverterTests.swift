//
//  CurrencyConverterTests.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 28/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest
@testable import Money

class CurrencyConverterTests: XCTestCase {

    var converter: CurrencyConverter!

    override func setUp() {
        let euroToPoundRate = CurrencyExchangeRate(baseToTargetCurrencyConversionRate: 0.87295,
                                                         targetCurrency: .poundSterling)

        let euroToUSDollarRate = CurrencyExchangeRate(baseToTargetCurrencyConversionRate: 1.12979,
                                                            targetCurrency: .usDollar)

        converter = CurrencyConverter(baseCurrency: .euro,
                                      targetCurrencyExchangeRates: [euroToPoundRate, euroToUSDollarRate])
    }

    override func tearDown() {

        converter = nil
    }

    func testConversionFromBaseToTargetCurrency() {
        let twoEuroAndChange = Money(value: 2.13, currency: .euro)
        guard let twoEuroAndChangeInUSDollars = converter.convert(money: twoEuroAndChange, to: .usDollar) else {
            XCTAssert(false); return
        }
        XCTAssert (twoEuroAndChangeInUSDollars.value == 2.41)
    }

    func testBackConversion() {
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

    func testConversionFromTargetToBaseCurrency() {
        let twoDollarsAndChange = Money(value: 2.26, currency: .usDollar)
        guard let twoDollarsAndChangeInEuro = converter.convert(money: twoDollarsAndChange,
                                                                to: .euro) else {
            XCTAssert(false); return
        }
        XCTAssert(twoDollarsAndChangeInEuro == Money(value: 2, currency: .euro))
    }

    func testConversionFromTargetToBaseCurrencyBackConversion() {
        let twoDollarsAndChange = Money(value: 2.26, currency: .usDollar)
        guard let twoDollarsAndChangeInEuro = converter.convert(money: twoDollarsAndChange,
                                                                to: .euro) else {
                                                                    XCTAssert(false); return
        }

        guard let twoEuroBackConversionValue = converter.convert(money: twoDollarsAndChangeInEuro,
                                                                 to: .usDollar) else {
                                                                    XCTAssert(false); return
        }
        XCTAssert (twoEuroBackConversionValue == Money(value: 2.26, currency: .usDollar))
    }

    func testConvertToBaseCurrencyFromBaseCurrency() {
        let twoEuroAndChange = Money(value: 2.13, currency: .euro)
        guard let convertedTwoEuroAndChange = converter.convertMoneyToBaseCurrency(money: twoEuroAndChange) else {
            XCTAssert(false); return
        }
        XCTAssert (convertedTwoEuroAndChange == twoEuroAndChange)
    }

    func testConvertToTargetCurrencyFromBaseCurrency() {
        let twoEuroAndChange = Money(value: 2.13, currency: .euro)
        guard let convertedTwoEuroAndChange = converter.convert(money: twoEuroAndChange, to: .euro) else {
            XCTAssert(false); return
        }
        XCTAssert (convertedTwoEuroAndChange == twoEuroAndChange)
    }

    func testConvertToBaseCurrencyFromAnotherCurrency() {
        let twoDollarsAndChange = Money(value: 2.26, currency: .usDollar)
        guard let twoDollarsAndChangeInEuro = converter.convertMoneyToBaseCurrency(money: twoDollarsAndChange) else {
            XCTAssert(false); return
        }
        XCTAssert (twoDollarsAndChangeInEuro == Money(value: 2, currency: .euro))
    }

    func testSameCurrencyAdditionWithDifferentCurrencies() {

        Money.currencyConverter = converter
        let tenEuro = Money(value: 10, currency: .euro)
        let tenDollars = Money(value: 10, currency: .usDollar)
        let tenDollarsInEuro = 10 * (1 / 1.12979)
        XCTAssertTrue(tenEuro + tenDollars == Money(value: 10 + tenDollarsInEuro,
                                                    currency: .euro) )
        Money.currencyConverter = nil
    }
}
