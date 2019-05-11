//
//  PredefinedCurrencies.swift
//  SwiftyMoneyTests
//
//  Created by Krystian Kopeć on 07/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

extension Currency {

    public static let euro = Currency(name: "Euro",
                                      code: "EUR",
                                      symbol: "€",
                                      exponent: 2)


    public static let polishZloty = Currency(name: "Polish zloty",
                                             code: "PLN",
                                             symbol: "zł",
                                             exponent: 2)

    public static let poundSterling = Currency(name: "Pound sterling",
                                               code: "GBP",
                                               symbol: "£",
                                               exponent: 2)

    public static let swedishKrona = Currency(name: "Swedish krona",
                                              code: "SEK",
                                              symbol: "kr",
                                              exponent: 0)

    public static let usDollar = Currency(name: "American dollar",
                                          code: "USD",
                                          symbol: "$",
                                          exponent: 2)
}
