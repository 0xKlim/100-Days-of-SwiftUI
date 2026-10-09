//
//  Order.swift
//  10_CupcakeCorner
//
//  Created by Vladislav on 08.10.2026.
//

import SwiftUI

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var address: Address {
        didSet {
            saveAddress()
        }
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
    
    init() {
        if let encodedAddress = UserDefaults.standard.data(forKey: addressKey) {
            if let decodedAddress = try? JSONDecoder().decode(Address.self, from: encodedAddress) {
                self.address = decodedAddress
                return
            }
        }
        self.address = Address()
    }
    
    private let addressKey = "UserAddress"
    
    func saveAddress() {
        if let encodedAddress = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encodedAddress, forKey: addressKey)
        }
    }
}


