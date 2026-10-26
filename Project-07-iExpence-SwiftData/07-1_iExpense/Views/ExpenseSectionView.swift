//
//  ExpenseSectionView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 30.09.2026.
//

import SwiftUI
import SwiftData

struct ExpenseSectionView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [ExpenseItem]
    
    let name: String
    
    var body: some View {
        if !items.isEmpty {
            Section(name) {
                ForEach(items) { item in
                    NavigationLink(value: Route.edit(item)) {
                        ItemRowView(item: item)
                    }
                }
                .onDelete(perform: removeItems(at:))
            }
        }
    }
    
    init(type: ExpenseType, sort: [SortDescriptor<ExpenseItem>]) {
        _items = Query(filter: #Predicate<ExpenseItem>{ item in
            item.type == type
        }, sort: sort)
        self.name = type.rawValue
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index])
        }
    }
    
}
 
#Preview {
    ExpenseSectionView(type: .personal, sort: [SortDescriptor<ExpenseItem>(\.name)])
}
