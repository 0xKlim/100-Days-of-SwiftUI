//
//  ContentView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 27.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ExpenseType.allCases) { type in
                    let filteredItems = expenses.items.filter { $0.type == type }
                    if !filteredItems.isEmpty {
                        ExpenseSectionView(items: filteredItems, name: type.rawValue, onDelete: removeItem(id:))
                    }
                }
            }
            .overlay {
                if expenses.items.isEmpty {
                    UnavailableView {
                        showingAddExpense = true
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItem(id: UUID) {
        expenses.items.removeAll(where: {$0.id == id})
    }
}

#Preview {
    ContentView()
}
