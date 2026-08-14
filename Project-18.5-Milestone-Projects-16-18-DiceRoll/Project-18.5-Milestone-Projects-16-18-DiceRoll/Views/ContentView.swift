//
//  ContentView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 07.08.2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \Player.name) var players: [Player]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        TabView {
            Tab {
                NavigationStack {
                    GameView()
                    .navigationTitle("Dice Roll")
                    .appBackground()
                }
            } label: {
                Label("Game", systemImage: "play")
            }
            
            Tab {
                NavigationStack {
                    HistoryView()
                    .navigationTitle("History")
                    .appBackground()
                }
            } label: {
                Label("History", systemImage: "clock.arrow.circlepath")
            }

            Tab {
                NavigationStack {
                    SettingsView()
                    .navigationTitle("Settings")
                    .appBackground()
                }
            } label: {
                Label("Settings", systemImage: "gearshape.2")
            }
        }
        .colorScheme(.dark)
        .onAppear {
            if players.isEmpty {
                modelContext.insert(Player.defaultPlayer(number: 0))
                modelContext.insert(Player.defaultPlayer(number: 1))
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Player.self, inMemory: true)
}
