//
//  ContentView.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 22.04.2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(AppStorageKeys.numberOfQuestions) var numberOfQuestions = 5
    @AppStorage(AppStorageKeys.maxMultiplicator) var maxMultiplicator = 5
    
    @State private var questions = [Question]()
    @State private var gameID = UUID()
    
    @State private var showingSheet = false
    @State private var isSettingsUpdated = false
    @State private var showingUpdatesAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                
                if !questions.isEmpty {
                    GameView(questions: questions, onEndGame: resetGame)
                        .id(gameID)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Edutainment")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Settings", systemImage: "gearshape") {
                        showingSheet = true
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset", action: resetGame)
                }
            }
            .sheet(isPresented: $showingSheet) {
                SettingsView(questions: numberOfQuestions, maxMultiplicator: maxMultiplicator) { newNumberOfQuestions, newMaxMultiplicator in
                    numberOfQuestions = newNumberOfQuestions
                    maxMultiplicator = newMaxMultiplicator
                    showingUpdatesAlert = true
                }
            }
            .alert("Settings updated", isPresented: $showingUpdatesAlert) {
                Button("Reset", role: .confirm, action: resetGame)
                Button("Resume", role: .cancel) { }
            } message: {
                Text("Do you want to reset current game with new settings?")
            }
            .onAppear {
                generateQuestions()
            }
        }
    }
    
    func resetGame() {
        gameID = UUID()
        generateQuestions()
    }
    
    func generateQuestions() {
        questions = (0..<numberOfQuestions).map { _ in
            Question(multiplicand: Int.random(in: 0...maxMultiplicator), multiplier: Int.random(in: 0...maxMultiplicator))
        }
    }
}

#Preview {
    ContentView()
}

