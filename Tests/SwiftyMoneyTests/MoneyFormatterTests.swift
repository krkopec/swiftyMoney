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

    var money = Money(value: 10, currency: .euro)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

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
