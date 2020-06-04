//
//  Currency.swift
//  Money
//
//  Created by Krystian Kopeć on 02/03/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

/// A class representing the concept of a currency.
public class Currency {

    /// A property representing Currency's localizable name, e.g. "US Dollar"
    public let name: String

    /// A property representing Currency's international ISO code, e.g. "USD" for US Dollar.
    public let code: String

    /// A property representing Currency's exponent, e.g. the number of decimal places used by the currency's fractional unit
    public var exponent: Int

    /// A property representing Currency's main symbol, e.g. "$" for US Dollar.
    public let symbol: String?

    /// A complentary property used for differentiating between instances of the class
    public let identifier: UUID?

    // A property that handles the decimal number behaviour used by the currency
    public var decimalHandler: NSDecimalNumberHandler

    /// A property representing the countries that the currency is used in, as referenced by their ISO codes.
    public let countryCodes: Set<String>

    /// A property representing Currency's fractional unit, such as "cent" for US Dollar.
    public let fractionalUnitName: String

    public init(identifier: UUID? = nil,
                name: String,
                code: String,
                symbol: String?,
                exponent: Int,
                fractionalUnitName: String,
                countryCodes: Set<String> = []) {

        self.identifier = identifier
        self.name = name
        self.code = code
        self.symbol = symbol
        self.exponent = exponent
        self.fractionalUnitName = fractionalUnitName
        self.countryCodes = countryCodes
        
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
    open func hash(into hasher: inout Hasher) {
        hasher.combine(code)
        hasher.combine(identifier)
    }
}
