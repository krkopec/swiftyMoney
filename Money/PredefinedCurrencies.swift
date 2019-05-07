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
                                                  symbol: "$",
                                                  subunit: CurrencySubunit(symbol: "c",
                                                                           roundingScale: 2))

    public static let czechKoruna = Currency(name: "Czech koruna",
                                             code: "CZK",
                                             symbol: "Kč",
                                             subunit: nil)

    public static let euro = Currency(name: "Euro",
                                      code: "EUR",
                                      symbol: "€",
                                      subunit: CurrencySubunit(symbol: "c",
                                                               roundingScale: 2))


    public static let polishZloty = Currency(name: "Polish zloty",
                                             code: "PLN",
                                             symbol: "zł",
                                             subunit: CurrencySubunit(symbol: "gr",
                                                                      roundingScale: 2))

    public static let poundSterling = Currency(name: "Pound sterling",
                                               code: "GBP",
                                               symbol: "£",
                                               subunit: CurrencySubunit(symbol: "p",
                                                                        roundingScale: 2))

    public static let swedishKrona = Currency(name: "Swedish krona",
                                              code: "SEK",
                                              symbol: "kr",
                                              subunit: nil)

    public static let swissFranc = Currency(name: "Swiss Franc",
                                            code: "CHF",
                                            symbol: "Fr",
                                            subunit: nil)

    public static let usDollar = Currency(name: "American dollar",
                                          code: "USD",
                                          symbol: "$",
                                          subunit: CurrencySubunit(symbol: "c",
                                                                   roundingScale: 2))
}
