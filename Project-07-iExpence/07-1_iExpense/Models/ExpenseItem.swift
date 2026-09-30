//
//  ExpenseItem.swift
//  07-1_iExpense
//
//  Created by Vladislav on 29.09.2026.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
