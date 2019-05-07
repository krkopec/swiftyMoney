//
//  Money.swift
//  Money
//
//  Created by Krystian Kopeć on 17/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//


import Foundation

/// A structure representing the concept of money.
public struct Money {

    public var value: Decimal {
        return NSDecimalNumber(decimal: _value).rounding(accordingToBehavior: currency.decimalHandler) as Decimal
    }

    public let currency: Currency

    // Static property used for currency conversion directly on the Money struct; must not be nil if any conversions are to be done
    public private(set) static var currencyConverter: CurrencyConverter?
    private let _value: Decimal

    public init(value: Decimal, currency: Currency) {
        self.currency = currency
        self._value = value
    }

    public init(value: Double, currency: Currency) {
        self.currency = currency
        self._value = Decimal(value)
    }

    public init(value: Int, currency: Currency) {
        self.currency = currency
        self._value = Decimal(value)
    }

    public static func setCurrencyConverter(to currencyConverter: CurrencyConverter?) {
        self.currencyConverter = currencyConverter
    }
}

extension Money: Equatable {
    public static func == (lhs: Money, rhs: Money) -> Bool {
            return lhs.value == rhs.value && lhs.currency == rhs.currency
    }
}

// Currency conversion methods; may return nil if currencyConverter is not set
extension Money {

    /// A method that converts money to the base currency specified in Money's static currency converter
    func convertedToBaseCurrency() -> Money? {

        guard let converter = Money.currencyConverter,
              let baseCurrency = converter.baseCurrency
        else {
            print("Money.currencyConverter is nil")
            return nil
        }
        return converter.convert(money: self, to: baseCurrency)
    }

    /// A method that converts money to another currency, according to conversion rates specified in Money's static currency converter
    func converted(to currency: Currency) -> Money? {

        guard let converter = Money.currencyConverter else {
            print("Money.currencyConverter is nil")
            return nil
        }
        return converter.convert(money: self, to: currency)
    }
}

// When performing subtraction and addition on Money, the result will be returned:
// 1. in original currency if both amounts are in the same currency,
// 2. in converter's base currency if the amounts are in different currencies
// and a currency converter was set
// 3. as nil value if they are in different currencies and no currency converter or no
// corresponding currency exchange rates were set

extension Money {
    public static func + (lhs: Money, rhs: Money) -> Money? {

        if lhs.currency == rhs.currency {
            return Money(value: lhs.value + rhs.value, currency: lhs.currency)
        } else {
            guard currencyConverter != nil else {
                print("Money.currencyConverter is nil")
                return nil
            }

            guard let lhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: lhs),
                let rhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: rhs)
                else {
                    print("Could not convert money to currency converter's base currency")
                    return nil
            }

            return lhsInBaseCurrency + rhsInBaseCurrency
        }
    }
    public static func - (lhs: Money, rhs: Money) -> Money? {

        if lhs.currency == rhs.currency {
            return Money(value: lhs.value - rhs.value, currency: lhs.currency)
        } else {
            guard currencyConverter != nil else {
                print("Money.currencyConverter is nil")
                return nil
            }

            guard let lhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: lhs),
                let rhsInBaseCurrency = currencyConverter?.convertMoneyToBaseCurrency(money: rhs)
                else {
                    print("Could not convert money to currency converter's base currency")
                    return nil
            }

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
