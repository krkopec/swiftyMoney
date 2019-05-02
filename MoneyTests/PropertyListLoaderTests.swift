//
//  PropertyListLoader.swift
//  MoneyTests
//
//  Created by Krystian Kopeć on 01/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import XCTest
@testable import Money

public struct CurrencyExchangeRatePackage: Codable {
    let baseCurrencyCode: String
    let rates: [String: Double]
}

class PropertyListLoaderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUrlLoading() {

        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "eurExchangeRates", ofType: "plist")
        XCTAssertNotNil(filePath)
    }

    func testPropertyListLoading() {

        let testBundle = Bundle(for: type(of: self))
        guard let plistPath = testBundle.path(forResource: "eurExchangeRates", ofType: "plist") else {
            XCTFail(); return
        }
        let plistFileUrl = URL(fileURLWithPath: plistPath)

        guard let rates = PropertyListLoader().load(plistUrl: plistFileUrl,
                                                    as: CurrencyExchangeRatePackage.self)
            else {
                XCTFail(); return
        }

        XCTAssert(rates.baseCurrencyCode == "EUR")
    }
}
