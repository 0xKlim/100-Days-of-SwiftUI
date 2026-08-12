//
//  EditPlayerView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 10.08.2026.
//

import SwiftUI

struct EditPlayerView: View {
    @Environment(\.dismiss) var dismiss
    
    let player: Player
    let onSave: (Player) -> Void
    let onDelete: (Player) -> Void
    
    @State private var name: String
    
    init(player: Player, onSave: @escaping (Player) -> Void, onDelete: @escaping (Player) -> Void) {
        self.player = player
        self.name = player.name
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }
            
            Section {
                HStack {
                    Spacer()
                    Button("Delete", role: .destructive) {
                        onDelete(player)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Edit Player")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", action: {
                    player.name = name
                    onSave(player)
                    dismiss()
                })
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditPlayerView(player: Player(name: "Dava")) { player in
            
        } onDelete: { player in
            
        }
    }
}
