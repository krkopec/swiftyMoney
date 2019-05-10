//
//  CurrencyFormatter.swift
//  Money
//
//  Created by Krystian Kopeć on 05/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

public class MoneyFormatter {

    let formatter = NumberFormatter()

    public init() {
        formatter.numberStyle = .currency
    }

    public func set(defaultLocale: Locale) {
        formatter.locale = defaultLocale
    }

    public func shortString(from money: Money, locale: Locale, style: NumberFormatter.Style) -> String? {

        let formatter = NumberFormatter()
        formatter.currencyCode = money.currency.code
        formatter.numberStyle = style
        formatter.currencySymbol = money.currency.symbol
        formatter.maximumFractionDigits = money.currency.subunit?.roundingScale ?? 0
        formatter.locale = locale

        guard let moneyString = formatter.string(from: money.value as NSNumber)
            else {
                print("Could not produce a formatting string for \(money)")
                return nil
        }
        return moneyString
    }
}
