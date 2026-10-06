//
//  ContentView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 27.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var path = [Route]()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                        navigateToAddItem()
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    navigateToAddItem()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .add:
                    ExpenseDetailView(of: nil, onSave: updateItem(_:))
                case .edit(let item):
                    ExpenseDetailView(of: item, onSave: updateItem(_:))
                }
            }
        }
    }
    
    func updateItem(_ item: ExpenseItem) {
        if let index = expenses.items.firstIndex(where: {$0.id == item.id}) {
            expenses.items[index] = item
        } else {
            expenses.items.append(item)
        }
    }
    
    func navigateToAddItem() {
        path.append(.add)
    }
    
    func removeItem(id: UUID) {
        expenses.items.removeAll(where: {$0.id == id})
    }
}

#Preview {
    ContentView()
}
