//
//  CurrencySubunit.swift
//  Money
//
//  Created by Krystian Kopeć on 07/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//

import Foundation

public struct CurrencySubunit {

    /// A property that specifies the Currency's subunit symbol, e.g. "c" for US dollar cents.
    let symbol: String

    /// A property that specifies the number of allowable decimal places ; 0 means no decimal values and no subunit symbols are permitted.
    let roundingScale: Int
}

extension CurrencySubunit: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
        hasher.combine(roundingScale)
    }
}

extension CurrencySubunit: Equatable {
    public static func == (lhs: CurrencySubunit, rhs: CurrencySubunit) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
