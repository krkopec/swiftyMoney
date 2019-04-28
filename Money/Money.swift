//
//  Money.swift
//  Money
//
//  Created by Krystian Kopeć on 17/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//


import Foundation

public struct Money {

    public let value: Decimal
    public let currency: Currency

    public static let decimalHandler = NSDecimalNumberHandler(roundingMode: .bankers,
                                                              scale: 2,
                                                              raiseOnExactness: true,
                                                              raiseOnOverflow: true,
                                                              raiseOnUnderflow: true,
                                                              raiseOnDivideByZero: false)
    // needs to be set, if currency conversion on Money type is to be done
    public static var currencyConverter: CurrencyConverter?

    public init(value: Decimal, currency: Currency) {
        self.currency = currency
        self.value = value
    }

    public init(value: Double, currency: Currency) {
        self.currency = currency
        self.value = Decimal(value)
    }

    public init(value: Int, currency: Currency) {
        self.currency = currency
        self.value = Decimal(value)
    }
}

extension Money: Comparable {
    public static func < (lhs: Money, rhs: Money) -> Bool {
        if lhs.currency == rhs.currency {
            return lhs.value < rhs.value
        } else {
            guard let currencyConverter = currencyConverter else {
                fatalError("Money type currencyConverter is empty; please set Money.currencyConverter in order to convert Money to another Currency")
            }
            guard let lhsBaseValue = currencyConverter.convertMoneyToBaseCurrency(money: lhs) else {
                fatalError("Could not convert money: \(lhs) to base currency: \(currencyConverter.baseCurrency)")
            }
            guard let rhsBaseValue = currencyConverter.convertMoneyToBaseCurrency(money: rhs) else {
                fatalError("Could not convert money: \(rhs) to base currency: \(currencyConverter.baseCurrency)")
            }
            return lhsBaseValue < rhsBaseValue
        }
    }
}

extension Money: Equatable {

    public static func == (lhs: Money, rhs: Money) -> Bool {
            return lhs.value == rhs.value && lhs.currency == rhs.currency
    }
}

// when performing mathematical operations on monies, if they are of different currencies,
// the result is returned in the base unit currency or equals nil if base unit values cannot be unwrapped

extension Money {
    public static func + (lhs: Money, rhs: Money) -> Money? {
        if lhs.currency == rhs.currency {
            return Money(value: lhs.value + rhs.value, currency: lhs.currency)
        } else {
            fatalError("At least one of the monies could not be converted to baseUnitValue")
        }
    }

    public static func - (lhs: Money, rhs: Money) -> Money? {
        if lhs.currency == rhs.currency {
            return Money(value: lhs.value - rhs.value, currency: lhs.currency)
        } else {
            fatalError("At least one of the monies could not be converted to baseUnitValue")
        }
    }

    public static func * (lhs: Money, rhs: Decimal) -> Money? {
        return Money(value: lhs.value * rhs, currency: lhs.currency)
    }

    public static func * (lhs: Decimal , rhs: Money) -> Money? {
        return Money(value: rhs.value * lhs, currency: rhs.currency)
    }
}
