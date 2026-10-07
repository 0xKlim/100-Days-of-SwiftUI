//
//  DetailView.swift
//  -04_Consolidation_HabitTracker
//
//  Created by Vladislav on 07.10.2026.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let activity: ActivityItem?
    
    @State private var name: String
    @State private var description: String
    @State private var completionCount: Int
    
    let onSave: (ActivityItem) -> Void
    
    @State private var showingConfirmationAlert = false
    
    init(activity: ActivityItem?, onSave: @escaping (ActivityItem) -> Void) {
        self.activity = activity
        self.name = activity?.name ?? ""
        self.description = activity?.description ?? ""
        self.completionCount = activity?.completionCount ?? 0
        self.onSave = onSave
    }
    
    var isNewMode: Bool {
        activity == nil
    }
    
    var nameFormatted: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var descriptionFormatted: String {
        description.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isUpdated: Bool {
        if let activity {
            name != activity.name || description != activity.description || completionCount != activity.completionCount
        } else {
            !nameFormatted.isEmpty || !descriptionFormatted.isEmpty || completionCount != 0
        }
    }
    
    var isSaveble: Bool {
        !nameFormatted.isEmpty && isUpdated
    }
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Enter name", text: $name)
            }
            
            Section("Description") {
                TextField("Enter desctiption", text: $description)
            }
            
            Section {
                CounterView(number: completionCount, onIncrease: increaseCompletionCount, onDecrease: decreaseCompletionCount)
            }
        }
        .navigationTitle(isNewMode ? "New activity" : "Edit activity")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    save()
                    dismiss()
                }
                .disabled(!isSaveble)
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    if isUpdated {
                        showingConfirmationAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    if isNewMode {
                        Text ("Cancel")
                    } else {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
        .alert("Confirm your action", isPresented: $showingConfirmationAlert) {
            Button("Exit", role: .destructive) {
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Updated data will be removed!")
        }
    }
    
    func increaseCompletionCount() {
            withAnimation {
                completionCount += 1
            }
    }
    
    func decreaseCompletionCount() {
        if completionCount > 0 {
            withAnimation {
                completionCount -= 1
            }
        }
    }
    
    func save() {
        let newActivity = ActivityItem(id: activity?.id ?? UUID(), name: nameFormatted, description: descriptionFormatted, completionCount: completionCount)
        onSave(newActivity)
    }
}

private struct CounterView: View {
    let number: Int
    let onIncrease: () -> Void
    let onDecrease: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("COMPLETED")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            
            HStack(spacing: 24) {
                CompletionButton(systemName: "minus", tint: .red, action: onDecrease)
                .disabled(number <= 0)
                
                Text("\(number)")
                    .font(.largeTitle.bold())
                    .monospacedDigit()
                    .contentTransition(.numericText())
                
                CompletionButton(systemName: "plus", tint: .green, action: onIncrease)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

private struct CompletionButton: View {
    let systemName: String
    let tint: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title2.bold())
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
        .tint(tint)
    }
}

#Preview {
    let newMode = true
    var item: ActivityItem? {
        if newMode {
            nil
        } else {
            ActivityItem(name: "aa", description: "aaa")
        }
    }
    NavigationStack {
        DetailView(activity: item) { item in
            
        }
    }
}
