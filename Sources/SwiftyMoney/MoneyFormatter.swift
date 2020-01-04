//
//  CurrencyFormatter.swift
//  Money
//
//  Created by Krystian Kopeć on 05/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

public class MoneyFormatter {

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        return formatter
    }()


    public func set(defaultLocale: Locale) {
        formatter.locale = defaultLocale
    }

    public func set(style: NumberFormatter.Style) {
        formatter.numberStyle = style
    }

    public func string(from money: Money) -> String? {

        formatter.currencyCode = money.currency.code
        formatter.currencySymbol = money.currency.symbol
        formatter.maximumFractionDigits = money.currency.exponent

        guard let moneyString = formatter.string(from: money.value as NSNumber)
            else {
                print("Could not produce a formatting string for \(money)")
                return nil
        }
        return moneyString
    }
}
