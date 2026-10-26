//
//  ContentView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 27.04.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [ExpenseItem]
    
    @State private var sortOrder: [SortDescriptor<ExpenseItem>] = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    @State private var chosenExpenseTypes: [ExpenseType] = ExpenseType.allCases
    @State private var path = [Route]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(chosenExpenseTypes) { type in
                    ExpenseSectionView(type: type, sort: sortOrder)
                }
            }
            .overlay {
                if items.isEmpty {
                    UnavailableView {
                        navigateToAddItem()
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button("Add Expense", systemImage: "plus") {
                        navigateToAddItem()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Picker("Show", selection: $chosenExpenseTypes) {
                        Text("Show all")
                            .tag(ExpenseType.allCases)
                        ForEach(ExpenseType.allCases) { type in
                            Text("\(type.rawValue) only")
                                .tag([type])
                        }
                    }
                }
                
                ToolbarItem(placement: .primaryAction){
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder) {
                            Text("By Name (A to Z)")
                                .tag([
                                    SortDescriptor<ExpenseItem>(\.name),
                                    SortDescriptor<ExpenseItem>(\.amount, order: .reverse)
                                ])
                            Text("By Name (Z to A)")
                                .tag([
                                    SortDescriptor<ExpenseItem>(\.name, order: .reverse),
                                    SortDescriptor<ExpenseItem>(\.amount, order: .reverse)
                                ])
                            Text("Lowes Amount First")
                                .tag([
                                    SortDescriptor<ExpenseItem>(\.amount),
                                    SortDescriptor<ExpenseItem>(\.name)
                                ])
                            Text("Highest Amount First")
                                .tag([
                                    SortDescriptor<ExpenseItem>(\.amount, order: .reverse),
                                    SortDescriptor<ExpenseItem>(\.name)
                                ])
                        }
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .add:
                    ExpenseDetailView(of: nil)
                case .edit(let item):
                    ExpenseDetailView(of: item)
                }
            }
        }
    }
    
    func navigateToAddItem() {
        path.append(.add)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self, inMemory: true)
}
