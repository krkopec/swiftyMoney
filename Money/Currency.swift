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

// MARK: Currency examples
extension Currency {

    public static let australianDollar = Currency(name: "Australian dollar",
                                                  code: "AUD",
                                                  unitSymbol: CurrencySymbol(symbol: "$",
                                                                             position: .before),
                                                  subunitSymbol: CurrencySymbol(symbol: "c",
                                                                                position: .after))
    public static let czechKoruna = Currency(name: "Czech koruna",
                                             code: "CZK",
                                             unitSymbol: CurrencySymbol(symbol: "Kč",  position: .after),
                                             subunitSymbol: nil)
    public static let euro = Currency(name: "Euro",
                                      code: "EUR",
                                      unitSymbol: CurrencySymbol(symbol: "€",  position: .before),
                                      subunitSymbol: CurrencySymbol(symbol: "c",  position: .after))
    public static let polishZloty = Currency(name: "Polish zloty",
                                             code: "PLN",
                                             unitSymbol: CurrencySymbol(symbol: "zł", position: .after),
                                             subunitSymbol: CurrencySymbol(symbol: "gr", position: .after))
    public static let poundSterling = Currency(name: "Pound sterling",
                                               code: "GBP",
                                               unitSymbol: CurrencySymbol(symbol: "£",
                                                                          position: .before),
                                               subunitSymbol: CurrencySymbol(symbol: "p",
                                                                             position: .after))
    public static let swedishKrona = Currency(name: "Swedish krona",
                                              code: "SEK",
                                              unitSymbol: CurrencySymbol(symbol: "kr", position: .after),
                                              subunitSymbol: nil)
    public static let swissFranc = Currency(name: "Swiss Franc",
                                            code: "CHF",
                                            unitSymbol: CurrencySymbol(symbol: "Fr", position: .after),
                                            subunitSymbol: nil)
    public static let usDollar = Currency(name: "American dollar",
                                          code: "USD",
                                          unitSymbol: CurrencySymbol(symbol: "$",  position: .before),
                                          subunitSymbol: CurrencySymbol(symbol: "c", position: .before))

    public static var predefinedCurrencies: Set<Currency> = [Currency.australianDollar,
                                                             Currency.czechKoruna,
                                                             Currency.euro,
                                                             Currency.australianDollar,
                                                             Currency.polishZloty,
                                                             Currency.poundSterling,
                                                             Currency.swedishKrona,
                                                             Currency.swissFranc,
                                                             Currency.usDollar]

    public static func insertPredefinedCurrency(currency: Currency) {
        Currency.predefinedCurrencies.insert(currency)
    }
}
