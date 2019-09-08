//
//  Currency.swift
//  Money
//
//  Created by Krystian Kopeć on 02/03/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

/// A structure representing the concept of a currency.
public class Currency {

    /// A property representing Currency's localizable name, e.g. "US Dollar"
    public let name: String

    /// A property representing Currency's international ISO code, e.g. USD for US dollar.
    public let code: String

    /// A property representing Currency's exponent.
    public var exponent: Int

    /// A property representing Currency's main symbol, e.g. "$" for US dollar.
    public let symbol: String

    // A property that handles the decimal number behaviour used by the currency
    public var decimalHandler: NSDecimalNumberHandler

    public init(name: String, code: String, symbol: String, exponent: Int) {

        self.name = name
        self.code = code
        self.symbol = symbol
        self.exponent = exponent
        
        decimalHandler = NSDecimalNumberHandler(roundingMode: .bankers,
                                                scale: Int16(exponent),
                                                raiseOnExactness: true,
                                                raiseOnOverflow: true,
                                                raiseOnUnderflow: true,
                                                raiseOnDivideByZero: false)
    }
    
    /// A function that makes it possible to modify Currency's decimal number handler
    public func setDecimalHandler(to decimalHandler: NSDecimalNumberHandler) {
        self.decimalHandler = decimalHandler
    }
}

extension Currency: Equatable {
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension Currency: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(code)
        hasher.combine(symbol)
        hasher.combine(exponent)
    }
}