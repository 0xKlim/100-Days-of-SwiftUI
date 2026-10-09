//
//  Address.swift
//  10_CupcakeCorner
//
//  Created by Vladislav on 09.10.2026.
//

import Foundation

struct Address: Codable {
    var name: String
    var streetAddress: String
    var city: String
    var zip: String
    
    var hasValidAddress: Bool {
        ![name, streetAddress, city, zip].contains(where: {
            $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        })
    }
    
    init(name: String = "", streetAddress: String = "", city: String = "", zip: String = "") {
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
    }
}
