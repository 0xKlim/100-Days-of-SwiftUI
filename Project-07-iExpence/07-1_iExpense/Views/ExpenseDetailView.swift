//
//  ExpenseDetailView.swift
//  07-1_iExpense
//
//  Created by Vladislav on 30.09.2026.
//

import SwiftUI

struct ExpenseDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let expenseItem: ExpenseItem?
    let onSave: (ExpenseItem) -> Void
    
    @State private var name: String
    @State private var type: ExpenseType
    @State private var amount: Double
    @State private var showingAlert = false
    
    init(of expenseItem: ExpenseItem?, onSave: @escaping (ExpenseItem) -> Void) {
        self.expenseItem = expenseItem
        self.name = expenseItem?.name ?? ""
        self.type = expenseItem?.type ?? .personal
        self.amount = expenseItem?.amount ?? 0
        self.onSave = onSave
    }
    
    var nameFormatted: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isNew: Bool {
        expenseItem == nil
    }
    
    var isUpdated: Bool {
        if let expenseItem {
            return nameFormatted != expenseItem.name || amount != expenseItem.amount
        } else {
            return !nameFormatted.isEmpty || amount != 0
        }
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            
            Picker("Type", selection: $type) {
                ForEach(ExpenseType.allCases) {
                    Text($0.rawValue)
                }
            }
            
            TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .keyboardType(.decimalPad)
        }
        .navigationTitle(isNew ? "New Expense" : "Edit Expense")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    save()
                    dismiss()
                }
                .disabled(nameFormatted.isEmpty)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    if isUpdated {
                        showingAlert = true
                    } else {
                        dismiss()
                    }
                }
            }
        }
        .alert("Confirm your action", isPresented: $showingAlert) {
            Button("Exit", role: .destructive) {
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Updated data will be removed!")
        }
    }
    
    func save() {
        let newExpenseItem = ExpenseItem(id: expenseItem?.id ?? UUID(), name: nameFormatted, type: type, amount: amount)
        onSave(newExpenseItem)
    }
}

#Preview {
    NavigationStack {
        ExpenseDetailView(of: nil) { _ in
            
        }
    }
}

