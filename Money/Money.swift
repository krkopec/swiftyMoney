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
        self.value = NSDecimalNumber(decimal: value).rounding(accordingToBehavior: Money.decimalHandler) as Decimal
    }

    public init(value: Double, currency: Currency) {
        self.currency = currency
        self.value = NSDecimalNumber(floatLiteral: value).rounding(accordingToBehavior: Money.decimalHandler) as Decimal
    }

    public init(value: Int, currency: Currency) {
        self.currency = currency
        self.value = NSDecimalNumber(integerLiteral: value).rounding(accordingToBehavior: Money.decimalHandler) as Decimal
    }
}

extension Money: Equatable {
    public static func == (lhs: Money, rhs: Money) -> Bool {
            return lhs.value == rhs.value && lhs.currency == rhs.currency
    }
}


// When performing mathematical operations on monies, the result is returned:
// 1. in original currency if both amounts have the same currency,
// 2. in converter's base currency if they are of different currencies and a currency converter was set
// 3. as nil if they are of different currencies and no currency converter was set
extension Money {
    public static func + (lhs: Money, rhs: Money) -> Money? {
        if lhs.currency == rhs.currency {
            return Money(value: lhs.value + rhs.value, currency: lhs.currency)
        } else {
            guard currencyConverter != nil,
                  let lhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: lhs),
                  let rhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: rhs)
            else { return nil }

            return lhsInBaseCurrency + rhsInBaseCurrency
        }
    }

    public static func - (lhs: Money, rhs: Money) -> Money? {
        if lhs.currency == rhs.currency {
            return Money(value: lhs.value - rhs.value, currency: lhs.currency)
        } else {
            guard currencyConverter != nil,
                  let lhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: lhs),
                  let rhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: rhs)
            else { return nil }

            return lhsInBaseCurrency - rhsInBaseCurrency
        }
    }

    public static func * (lhs: Money, rhs: Decimal) -> Money? {
        return Money(value: lhs.value * rhs, currency: lhs.currency)
    }

    public static func * (lhs: Decimal , rhs: Money) -> Money? {
        return Money(value: rhs.value * lhs, currency: rhs.currency)
    }

    public static func * (lhs: Money, rhs: Double) -> Money? {
        return Money(value: lhs.value * Decimal(rhs), currency: lhs.currency)
    }

    public static func * (lhs: Double , rhs: Money) -> Money? {
        return Money(value: rhs.value * Decimal(lhs), currency: rhs.currency)
    }

    public static func * (lhs: Money, rhs: Int) -> Money? {
        return Money(value: lhs.value * Decimal(rhs), currency: lhs.currency)
    }

    public static func * (lhs: Int , rhs: Money) -> Money? {
        return Money(value: rhs.value * Decimal(lhs), currency: rhs.currency)
    }

    public static func / (lhs: Money , rhs: Decimal) -> Money? {
        return Money(value: lhs.value / rhs, currency: lhs.currency)
    }

    public static func / (lhs: Money , rhs: Double) -> Money? {
        return Money(value: lhs.value / Decimal(rhs), currency: lhs.currency)
    }

    public static func / (lhs: Money , rhs: Int) -> Money? {
        return Money(value: lhs.value / Decimal(rhs), currency: lhs.currency)
    }
}
