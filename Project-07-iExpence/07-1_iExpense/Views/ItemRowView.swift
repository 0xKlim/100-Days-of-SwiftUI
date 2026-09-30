//
//  ItemRowView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 30.09.2026.
//

import SwiftUI

struct ItemRowView: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            Text(item.name)
                .font(.headline)
            
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(item.amount > 100 ? .red : item.amount > 10 ? .orange : .green)
        }
    }
}

#Preview {
    ItemRowView(item: ExpenseItem.example)
}
