//
//  MoneyWithConversion.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 02/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest

class MoneyWithConversion: XCTestCase {

    var converter: CurrencyConverter!

    override func setUp() {
        let euroToPoundRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                                   targetCurrency: .poundSterling,
                                                   sourceToTargetRate: 0.87295)

        let euroToUSDollarRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                                      targetCurrency: .usDollar,
                                                      sourceToTargetRate: 1.12979)

        let poundToUSDollarRate = CurrencyExchangeRate(sourceCurrency: .poundSterling,
                                                       targetCurrency: .usDollar,
                                                       sourceToTargetRate: 1.30021)

        converter = CurrencyConverter(baseCurrency: .euro,
                                      targetCurrencyExchangeRates: [euroToPoundRate,
                                                                    euroToUSDollarRate,
                                                                    poundToUSDollarRate])
    }

    override func tearDown() {

        converter = nil
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

    func testMoneyConvertedToBaseCurrency() {

        Money.currencyConverter = converter
        let twoDollarsAndChange = Money(value: 2.40, currency: .usDollar)
        let twoDollarsAndChangeInEuro =  twoDollarsAndChange.convertedToBaseCurrency()
        XCTAssert ( twoDollarsAndChangeInEuro == Money(value: 2.12,
                                                       currency: .euro))
        Money.currencyConverter = nil
    }

    func testCurrencyConversionWithoutBaseCurrency() {

        Money.currencyConverter = converter
        let twoDollars = Money(value: 2, currency: .usDollar)
        let twoDollarsInPounds = twoDollars.converted(to: .poundSterling)
        XCTAssert ( twoDollarsInPounds == Money(value: 1.55,
                                                currency: .poundSterling))
        Money.currencyConverter = nil
    }
}
