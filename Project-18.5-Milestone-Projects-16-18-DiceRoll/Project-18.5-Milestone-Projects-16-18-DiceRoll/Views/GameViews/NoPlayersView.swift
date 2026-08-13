//
//  NoPlayersView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 13.08.2026.
//

import SwiftUI

struct NoPlayersView: View {
    let onTap: () -> Void
    var body: some View {
        Button {
            onTap()
        } label: {
            ContentUnavailableView {
                Label("NoPlayers", systemImage: "person.badge.plus")
            } description: {
                Text("Tap to add at least one player in settings to start rolling dice.")
            }
        }
    }
}

#Preview {
    NoPlayersView {
        
    }
}
