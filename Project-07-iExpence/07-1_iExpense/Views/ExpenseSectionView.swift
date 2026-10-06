//
//  ExpenseSectionView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 30.09.2026.
//

import SwiftUI

struct ExpenseSectionView: View {
    var items: [ExpenseItem]
    let name: String
    let onDelete: (UUID) -> Void
    
    var body: some View {
        Section(name) {
            ForEach(items) { item in
                NavigationLink(value: Route.edit(item)) { 
                    ItemRowView(item: item)
                }
            }
            .onDelete(perform: removeItems(at:))
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            onDelete(items[index].id)
        }
    }
}

#Preview {
    ExpenseSectionView(items: [ExpenseItem](), name: "Personal") { _ in }
}
