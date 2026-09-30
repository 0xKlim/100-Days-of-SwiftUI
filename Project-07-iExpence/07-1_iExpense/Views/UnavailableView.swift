//
//  UnavailableView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 30.09.2026.
//

import SwiftUI

struct UnavailableView: View {
    let onTap: () -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label("No Expenses", systemImage: "creditcard.badge.plus")
        } description: {
            Text("Please add your first expense.")
        } actions: {
            Button("Add Expense", action: onTap)
                .buttonStyle(.glassProminent)
        }
    }
}

#Preview {
    UnavailableView() { }
}
