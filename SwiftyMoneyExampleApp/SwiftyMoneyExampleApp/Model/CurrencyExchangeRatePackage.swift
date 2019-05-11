//
//  CurrencyExchangeRatePackage.swift
//  SwiftyMoneyExampleApp
//
//  Created by Krystian Kopeć on 08/05/2019.
//  Copyright © 2019 kr.kopec. All rights reserved.
//

import Foundation

public struct CurrencyExchangeRatePackage: Codable {
    let baseCurrencyCode: String
    let rates: [String: Double]
}
