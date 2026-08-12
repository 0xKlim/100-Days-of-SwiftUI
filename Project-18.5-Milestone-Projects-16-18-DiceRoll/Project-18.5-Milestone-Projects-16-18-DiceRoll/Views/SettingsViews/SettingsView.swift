//
//  SettingsView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 10.08.2026.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @AppStorage(AppStorageKeys.numberOfDice) var numberOfDice = 2
    @AppStorage(AppStorageKeys.numberOfFaces) var numberOfFaces = 6
    
    @Query(sort: \Player.name) var players: [Player]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Form {
            Section("Dice") {
                Picker("Number of dice:  \(numberOfDice)", selection: $numberOfDice) {
                    ForEach(1..<9) {
                        Text("\($0)")
                            .tag($0)
                    }
                }
                
                Stepper("Number of faces:  \(numberOfFaces)", value: $numberOfFaces, in: 1...999)
            }
            
            Section("Players") {
                List {
                    ForEach(players) { player in
                        NavigationLink("\(player.name)", value: player)
                    }
                    .onDelete(perform: delete(_:))
                    NavigationLink(value: Player.defaultPlayer(number: players.count)) {
                        Image(systemName: "plus")
                        Text("Add Player")
                    }
                    .foregroundStyle(.link)
                }
            }
        }
        .navigationDestination(for: Player.self, destination: { player in
            EditPlayerView(player: player, onSave: savePlayer, onDelete: deletePlayer)
        })
    }
    
    func savePlayer(_ editedPlayer: Player) {
        if let player = players.first(where: {$0.id == editedPlayer.id}) {
            player.name = editedPlayer.name
        } else {
            modelContext.insert(editedPlayer)
        }
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let player = players[index]
            deletePlayer(player)
        }
    }
    
    func deletePlayer(_ player: Player) {
        modelContext.delete(player)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .navigationTitle("Settings")
    }
}
