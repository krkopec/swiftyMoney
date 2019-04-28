//
//  Currency.swift
//  Money
//
//  Created by Krystian Kopeć on 02/03/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//
//  Contains Currency struct together with CurrencySymbol struct. The CurrencySymbol struct specifies what currency symbol is used for a specific currency and whether it should precede or follow the currency amount, e.g. $10 or 10 zł. To make it easier to use various currencies, the Currency struct can be extended with a public static property defining a specific currency, thus enabling dot notation of the struct itself, as shown below in currency examples.

import Foundation

// MARK: Currency Symbol
public struct CurrencySymbol {
    let symbol: String
    let position: SymbolPosition

    enum SymbolPosition {
        case before, after
    }
}

extension CurrencySymbol: Equatable {
    public static func == (lhs: CurrencySymbol, rhs: CurrencySymbol) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension CurrencySymbol: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
        hasher.combine(position)
    }
}

// MARK: Currency
public struct Currency {
    public let name: String
    public let code: String
    public let unitSymbol: CurrencySymbol
    public let subunitSymbol: CurrencySymbol?

    public static func getCurrency(forCurrencyCode code: String) -> Currency? {
        return Currency.predefinedCurrencies.first(where: { $0.code == code })
    }

    public static func insertPredefinedCurrency(currency: Currency) {
        Currency.predefinedCurrencies.insert(currency)
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
        hasher.combine(unitSymbol)
        hasher.combine(subunitSymbol)
    }
}
