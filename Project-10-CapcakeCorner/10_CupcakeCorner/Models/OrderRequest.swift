//
//  OrderRequest.swift
//  10_CupcakeCorner
//
//  Created by Vladislav on 09.10.2026.
//

import Foundation

struct OrderRequest: Codable {
    let type: Int
    let quantity: Int
    let specialRequestEnabled: Bool
    let extraFrosting: Bool
    let addSprinkles: Bool
    let name: String
    let streetAddress: String
    let city: String
    let zip: String
    
    init(from order: Order) {
        self.type = order.type
        self.quantity = order.quantity
        self.specialRequestEnabled = order.specialRequestEnabled
        self.extraFrosting = order.extraFrosting
        self.addSprinkles = order.addSprinkles
        self.name = order.address.name
        self.streetAddress = order.address.streetAddress
        self.city = order.address.city
        self.zip = order.address.zip
    }
}
