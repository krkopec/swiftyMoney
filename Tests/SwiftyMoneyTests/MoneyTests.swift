//
//  MoneyTests.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 17/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest
@testable import SwiftyMoney

class MoneyTests: XCTestCase {

    var euro: Currency!
    var usDollar: Currency!

    override func setUp() {

           euro = Currencies.getCurrency(withCurrencyCode: "EUR")!
           usDollar = Currencies.getCurrency(withCurrencyCode: "USD")!
    }

    // MARK: Test Money's Equatable conformance
    func testEquatabilityForSameCurrencyAndAmount() {
        let tenEuro = Money(value: 10, currency: euro)
        let anotherTenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro == anotherTenEuro)
    }

    func testEquatabilityForSameCurrencyDifferentAmount() {
        let tenEuro = Money(value: 9, currency: euro)
        let anotherTenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro != anotherTenEuro)
    }

    func testEquatabilityForDifferentCurrency() {
        let tenEuro = Money(value: 10, currency: euro)
        let anotherTenEuro = Money(value: 10, currency: usDollar)
        XCTAssertTrue(tenEuro != anotherTenEuro)
    }

    func testEquatabilityForDifferentCurrencyAndAmount() {
        let tenEuro = Money(value: 10, currency: euro)
        let anotherTenEuro = Money(value: 9, currency: usDollar)
        XCTAssertTrue(tenEuro != anotherTenEuro)
    }

    // MARK: Test Money mathematical operations
    func testSameCurrencyAddition() {
        let tenEuro = Money(value: 10, currency: euro)
        let twelveEuro = Money(value: 12, currency: euro)
        XCTAssertTrue(tenEuro + twelveEuro == Money(value: 22, currency: euro))
    }

    func testSameCurrencyAdditionWithDifferentCurrenciesAndNoConverter() {
        let tenEuro = Money(value: 10, currency: euro)
        let twelveDollars = Money(value: 12, currency: usDollar)
        XCTAssertTrue(tenEuro + twelveDollars == nil )
    }

    func testSameCurrencySubtraction() {
        let tenEuro = Money(value: 12, currency: euro)
        let twelveEuro = Money(value: 1, currency: euro)
        XCTAssertTrue(tenEuro - twelveEuro == Money(value: 11, currency: euro))
    }

    func testSameCurrencySubtractionWithNegativeResult() {
        let tenEuro = Money(value: 12, currency: euro)
        let twelveEuro = Money(value: 14, currency: euro)
        XCTAssertTrue(tenEuro - twelveEuro == Money(value: -2, currency: euro))
    }

    func testSameCurrencyMultiplicationWithIntegerValue() {
        let tenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro * 2 == Money(value: 20, currency: euro) && 10 * tenEuro == Money(value: 100, currency: euro))
    }

    func testSameCurrencyMultiplicationWithDecimalValue() {
        let tenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro * 2.5  == Money(value: 25, currency: euro) && 9.5 * tenEuro == Money(value: 95, currency: euro))
    }

    func testSameCurrencyMultiplicationWithDecimalValueVer2() {
        let tenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro * 2.55  == Money(value: 25.5, currency: euro) && 5.529 * tenEuro  == Money(value: 55.29, currency: euro))
    }

    func testSameCurrencyMultiplicationWithDecimalValueVer3() {
        let tenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro * 2.552341214  == Money(value: 25.52, currency: euro) && 5.529555 * tenEuro  == Money(value: 55.30, currency: euro))
    }

    func testSameCurrencyDivisionWithDecimal() {
        let tenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro / Decimal(2.5) == Money(value: 4, currency: euro))
    }

    func testSameCurrencyDivisionWithInt() {
        let tenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro / 2 == Money(value: 5, currency: euro))
    }

    func testSameCurrencyDivisionWithDouble() {
        let tenEuro = Money(value: 10, currency: euro)
        XCTAssertTrue(tenEuro / 2.5 == Money(value: 4, currency: euro))
    }
}
