//
//  ExpenseType.swift
//  07-1_iExpense
//
//  Created by Vladislav on 30.09.2026.
//

import Foundation

enum ExpenseType: String, CaseIterable, Identifiable, Codable {
    case personal = "Personal"
    case business = "Business"
    
    var id: Self { self }
}
