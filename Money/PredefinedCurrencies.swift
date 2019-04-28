//
//  CurrencyExtension.swift
//  Money
//
//  Created by Krystian Kopeć on 28/04/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

extension Currency {

    public static let australianDollar = Currency(name: "Australian dollar",
                                                  code: "AUD",
                                                  unitSymbol: CurrencySymbol(symbol: "$",
                                                                             position: .before),
                                                  subunitSymbol: CurrencySymbol(symbol: "c",
                                                                                position: .after))

    public static let czechKoruna = Currency(name: "Czech koruna",
                                             code: "CZK",
                                             unitSymbol: CurrencySymbol(symbol: "Kč",
                                                                        position: .after),
                                             subunitSymbol: nil)

    public static let euro = Currency(name: "Euro",
                                      code: "EUR",
                                      unitSymbol: CurrencySymbol(symbol: "€",
                                                                 position: .before),
                                      subunitSymbol: CurrencySymbol(symbol: "c",
                                                                    position: .after))

    public static let polishZloty = Currency(name: "Polish zloty",
                                             code: "PLN",
                                             unitSymbol: CurrencySymbol(symbol: "zł",
                                                                        position: .after),
                                             subunitSymbol: CurrencySymbol(symbol: "gr",
                                                                           position: .after))

    public static let poundSterling = Currency(name: "Pound sterling",
                                               code: "GBP",
                                               unitSymbol: CurrencySymbol(symbol: "£",
                                                                          position: .before),
                                               subunitSymbol: CurrencySymbol(symbol: "p",
                                                                             position: .after))

    public static let swedishKrona = Currency(name: "Swedish krona",
                                              code: "SEK",
                                              unitSymbol: CurrencySymbol(symbol: "kr",
                                                                         position: .after),
                                              subunitSymbol: nil)

    public static let swissFranc = Currency(name: "Swiss Franc",
                                            code: "CHF",
                                            unitSymbol: CurrencySymbol(symbol: "Fr",
                                                                       position: .after),
                                            subunitSymbol: nil)

    public static let usDollar = Currency(name: "American dollar",
                                          code: "USD",
                                          unitSymbol: CurrencySymbol(symbol: "$",
                                                                     position: .before),
                                          subunitSymbol: CurrencySymbol(symbol: "c",
                                                                        position: .before))

    public static var predefinedCurrencies: Set<Currency> = [.australianDollar,
                                                             .czechKoruna,
                                                             .euro,
                                                             .australianDollar,
                                                             .polishZloty,
                                                             .poundSterling,
                                                             .swedishKrona,
                                                             .swissFranc,
                                                             .usDollar]

    public static func getCurrency(forCurrencyCode code: String) -> Currency? {
        return Currency.predefinedCurrencies.first(where: { $0.code == code })
    }

    public static func insertPredefinedCurrency(currency: Currency) {
        Currency.predefinedCurrencies.insert(currency)
    }
}
