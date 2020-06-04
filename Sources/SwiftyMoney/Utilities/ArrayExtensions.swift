//
//  ArrayExtensions.swift
//  
//
//  Created by Krystian Kopeć on 04/06/2020.
//

import Foundation

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {

        return self.reduce(into: []) { (result, element) in
            if result.contains(element) == false {
                result.append(element)
            }
        }
    }
}
