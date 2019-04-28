//
//  MoneyTests.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 17/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest
@testable import Money

class MoneyTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Test Money equatability
    func testEquatabilityForSameCurrencyAndAmount() {
        let tenEuro = Money(value: 10, currency: .euro)
        let anotherTenEuro = Money(value: 10, currency: .euro)
        XCTAssertTrue(tenEuro == anotherTenEuro)
    }

    func testEquatabilityForSameCurrencyDifferentAmount() {
        let tenEuro = Money(value: 9, currency: .euro)
        let anotherTenEuro = Money(value: 10, currency: .euro)
        XCTAssertTrue(tenEuro != anotherTenEuro)
    }

    func testEquatabilityForDifferentCurrency() {
        let tenEuro = Money(value: 10, currency: .euro)
        let anotherTenEuro = Money(value: 10, currency: .usDollar)
        XCTAssertTrue(tenEuro != anotherTenEuro)
    }

    func testEquatabilityForDifferentCurrencyAndAmount() {
        let tenEuro = Money(value: 10, currency: .euro)
        let anotherTenEuro = Money(value: 9, currency: .usDollar)
        XCTAssertTrue(tenEuro != anotherTenEuro)
    }

    // Test Money comparability
    func testSameCurrencyComparability() {
        let tenEuro = Money(value: 10, currency: .euro)
        let twelveEuro = Money(value: 12, currency: .euro)
        XCTAssertTrue(tenEuro < twelveEuro)
    }

    func testDifferentCurrencyComparability() {
        let eurToDollarRate = TargetCurrencyExchangeRate(conversionRate: Decimal(1.12979),
                                                         targetCurrency: Currency.usDollar)
        let eurExchangeRatePackage = CurrencyExchangeRatePackage(createdAt: nil,
                                                           baseCurrency: Currency.euro,
                                                           targetCurrencyExchangeRates: [eurToDollarRate])
        Money.currencyConverter = CurrencyConverter(currencyExchangeRatePackage: eurExchangeRatePackage)
        let tenEuro = Money(value: 10, currency: .euro)
        let tenDollars = Money(value: 10, currency: .usDollar)
        XCTAssertTrue(tenEuro > tenDollars)
    }

    func testSameCurrencyAddition() {
        let tenEuro = Money(value: 10, currency: .euro)
        let twelveEuro = Money(value: 12, currency: .euro)
        XCTAssertTrue(tenEuro + twelveEuro == Money(value: 22, currency: .euro))
    }

    func testSameCurrencyMultiplicationWithIntegerValue() {
        let tenEuro = Money(value: 10, currency: .euro)
        XCTAssertTrue(tenEuro * 2 == Money(value: 20, currency: .euro) && 10 * tenEuro == Money(value: 100, currency: .euro))
    }

    func testSameCurrencyMultiplicationWithDecimalValue() {
        let tenEuro = Money(value: 10, currency: .euro)
        XCTAssertTrue(tenEuro * 2.5  == Money(value: 25, currency: .euro) && 9.5 * tenEuro == Money(value: 95, currency: .euro))
    }

    func testSameCurrencyMultiplicationWithDecimalValueVer2() {
        let tenEuro = Money(value: 10, currency: .euro)
        XCTAssertTrue(tenEuro * 2.55  == Money(value: 25.5, currency: .euro) && 5.529 * tenEuro  == Money(value: 55.29, currency: .euro))
    }


    func testIntegers() {
        let ten = Decimal(10)
        let two = Decimal(2)

        let result = ten / two
        XCTAssertTrue(two ==  ten  / result)
    }

    func testDecimals() {
        let ten = Decimal(11.25)
        let two = Decimal(2)

        let result = ten / two
        [two, ten, result].forEach {
            print($0.magnitude)
        }
        XCTAssertTrue(two ==  ten  / result)
    }
}
