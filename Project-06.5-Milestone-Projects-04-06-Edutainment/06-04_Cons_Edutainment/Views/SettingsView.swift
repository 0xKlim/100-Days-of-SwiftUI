//
//  SettingsView.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 24.09.2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    let initialQuestions: Int
    let initialMax: Int
    let onSave: (Int, Int) -> Void
    
    @State private var questions: Int
    @State private var maxMultiplicator: Int
    
    private let questionsAmounts = [5, 10, 15, 20]
    
    init(questions: Int, maxMultiplicator: Int, onSave: @escaping (Int, Int) -> Void) {
        self.initialQuestions = questions
        self.initialMax = maxMultiplicator
        self.onSave = onSave
        self.questions = questions
        self.maxMultiplicator = maxMultiplicator
    }
    
    var isChanged: Bool {
        questions != initialQuestions || maxMultiplicator != initialMax
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Group {
                    Section("Multiplication tables ") {
                        Stepper("Up to: \(maxMultiplicator)", value: $maxMultiplicator, in: 2...12)
                    }
                    
                    Section("Amount of questions") {
                        Picker("Amount of questions", selection: $questions) {
                            ForEach(questionsAmounts, id: \.self) { amount in
                                Text(amount.formatted())
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .listRowBackground(Color.white.opacity(0.7))
            }
            .scrollContentBackground(.hidden)
            .background(
                BackgroundView()
                    .rotationEffect(.degrees(180))
                    .ignoresSafeArea()
                    .opacity(0.5)
            )
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        if isChanged {
                            onSave(questions, maxMultiplicator)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(questions: 5, maxMultiplicator: 5) { _, _ in
        
    }
}
