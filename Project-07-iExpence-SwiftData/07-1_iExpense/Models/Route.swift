//
//  Route.swift
//  07-1_iExpense
//
//  Created by Vladislav on 06.10.2026.
//

import Foundation

enum Route: Hashable {
    case add
    case edit(ExpenseItem)
}
