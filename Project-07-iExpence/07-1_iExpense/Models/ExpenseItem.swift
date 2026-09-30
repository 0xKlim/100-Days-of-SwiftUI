//
//  ExpenseItem.swift
//  07-1_iExpense
//
//  Created by Vladislav on 29.09.2026.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let type: ExpenseType
    let amount: Double
    
    init(id: UUID = UUID(), name: String, type: ExpenseType, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
    
    #if DEBUG
    static let example = ExpenseItem(name: "Test", type: .personal, amount: 5)
    #endif
}
