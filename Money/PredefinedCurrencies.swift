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
                                                                             precedesAmount: true),
                                                  subunitSymbol: CurrencySymbol(symbol: "c",
                                                                                precedesAmount: false))

    public static let czechKoruna = Currency(name: "Czech koruna",
                                             code: "CZK",
                                             unitSymbol: CurrencySymbol(symbol: "Kč",
                                                                        precedesAmount: false),
                                             subunitSymbol: nil)

    public static let euro = Currency(name: "Euro",
                                      code: "EUR",
                                      unitSymbol: CurrencySymbol(symbol: "€",
                                                                 precedesAmount: true),
                                      subunitSymbol: CurrencySymbol(symbol: "c",
                                                                    precedesAmount: false))

    public static let polishZloty = Currency(name: "Polish zloty",
                                             code: "PLN",
                                             unitSymbol: CurrencySymbol(symbol: "zł",
                                                                        precedesAmount: false),
                                             subunitSymbol: CurrencySymbol(symbol: "gr",
                                                                           precedesAmount: false))

    public static let poundSterling = Currency(name: "Pound sterling",
                                               code: "GBP",
                                               unitSymbol: CurrencySymbol(symbol: "£",
                                                                          precedesAmount: true),
                                               subunitSymbol: CurrencySymbol(symbol: "p",
                                                                             precedesAmount: false))

    public static let swedishKrona = Currency(name: "Swedish krona",
                                              code: "SEK",
                                              unitSymbol: CurrencySymbol(symbol: "kr",
                                                                         precedesAmount: false),
                                              subunitSymbol: nil)

    public static let swissFranc = Currency(name: "Swiss Franc",
                                            code: "CHF",
                                            unitSymbol: CurrencySymbol(symbol: "Fr",
                                                                       precedesAmount: false),
                                            subunitSymbol: nil)

    public static let usDollar = Currency(name: "American dollar",
                                          code: "USD",
                                          unitSymbol: CurrencySymbol(symbol: "$",
                                                                     precedesAmount: true),
                                          subunitSymbol: CurrencySymbol(symbol: "c",
                                                                        precedesAmount: true))
}
