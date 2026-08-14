//
//  HistoryView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 10.08.2026.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Player.name) var players: [Player]
    
    @State private var showingWarningAlert = false
    
    var body: some View {
        Form {
            ForEach(players) { player in
                Section(player.name) {
                    HStack {
                        if !player.rolls.isEmpty {
                            let str = player.rolls.map( {String($0.diceSum)} ).joined(separator: ", ")
                            Text(str)
                        } else {
                            Text("Not rolled yet...")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Remove all", role: .destructive) {
                    showingWarningAlert = true
                }
                .disabled(players.allSatisfy({$0.rolls.isEmpty}))
            }
        }
        .alert("Remove all History", isPresented: $showingWarningAlert) {
            Button(role: .destructive, action: removeHistory)
        } message: {
            Text("Are you sure? This action can't be canceled!")
        }

    }
    
    func removeHistory() {
        players.forEach {$0.rolls.removeAll()}
    }
}

#Preview {
    HistoryView()
}
