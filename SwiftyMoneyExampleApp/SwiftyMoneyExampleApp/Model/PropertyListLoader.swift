//
//  PropertyListLoader.swift
//  Money
//
//  Created by Krystian Kopeć on 01/05/2019.
//  Copyright © 2019 Krystian Kopeć. All rights reserved.
//
//  Makes it easy to load property list files. In order to use it for currency conversion,
//  it is required to create a struct that conforms to Codable and follows closely the
//  structure of the plist file itself. See example in PropertyListLoaderTests

import Foundation

class PropertyListLoader {

    func load<T:Decodable>(plistUrl: URL, as type: T.Type) -> T? {

        do {
            let data = try Data(contentsOf: plistUrl)
            let output = try PropertyListDecoder().decode(type.self, from: data)
            return output
        } catch {
            print(error)
            return nil
        }
    }
}
