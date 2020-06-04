//
//  MoneyFormatterTests.swift
//  Money
//
//  Created by Krystian Kopeć on 05/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest
@testable import SwiftyMoney

class MoneyFormatterTests: XCTestCase {

    var money: Money!

    var euro: Currency!
    var poundSterling: Currency!
    var usDollar: Currency!

    var euroToPoundRate: CurrencyExchangeRate!
    var euroToUSDollarRate: CurrencyExchangeRate!
    var poundToUSDollarRate: CurrencyExchangeRate!

    override func setUp() {
        euro = Currencies.getCurrency(withCurrencyCode: "EUR")!
        poundSterling = Currencies.getCurrencies(forCountryCode: "UK").first!
        usDollar = Currencies.getCurrency(withCurrencyCode: "USD")!

        money = Money(value: 10, currency: euro)

        euroToPoundRate = CurrencyExchangeRate(sourceCurrency: euro,
                                               targetCurrency: poundSterling,
                                               allowsInverseConversion: true,
                                               sourceToTargetRate: 0.87295)

        euroToUSDollarRate = CurrencyExchangeRate(sourceCurrency: euro,
                                                  targetCurrency: usDollar,
                                                  allowsInverseConversion: true,
                                                  sourceToTargetRate: 1.12979)

        poundToUSDollarRate = CurrencyExchangeRate(sourceCurrency: poundSterling,
                                                   targetCurrency: usDollar,
                                                   allowsInverseConversion: true,
                                                   sourceToTargetRate: 1.29422)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFormatter1() {
        let expectedResult1 = "€10.00"
        let formatter = MoneyFormatter()
        formatter.set(defaultLocale: .init(identifier: "en"))
        let actualResult1 = formatter.string(from: money)
        XCTAssertTrue(expectedResult1 == actualResult1!)
    }

    func testFormatter2() {
        let expectedResult2 = "10,00 €"
        let formatter = MoneyFormatter()
        formatter.set(defaultLocale: .init(identifier: "pl"))
        let actualResult2 = formatter.string(from: money)
        XCTAssertTrue(expectedResult2 == actualResult2!)
    }

    func testFormatter3() {
        let formatter = MoneyFormatter()
        formatter.set(style: .currencyPlural)
        formatter.set(defaultLocale: .init(identifier: "pl_pl"))
        let expectedResult3 = "10,00 złotego polskiego"
        let actualResult3 = formatter.string(from: money)
        XCTAssertTrue(expectedResult3 == actualResult3!)
    }
    
    func testFormatter4() {
        let formatter = MoneyFormatter()
        formatter.set(defaultLocale: .init(identifier: "fr"))
        let expectedResult3 = "10,00 €"
        let actualResult3 = formatter.string(from: money)
        XCTAssertTrue(expectedResult3 == actualResult3!)
    }
}
