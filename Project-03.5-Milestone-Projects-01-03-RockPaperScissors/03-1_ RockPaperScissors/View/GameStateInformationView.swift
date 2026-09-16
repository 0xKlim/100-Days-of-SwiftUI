//
//  GameStateInformationView.swift
//  03-1_ RockPaperScissors
//
//  Created by Vladislav on 16.09.2026.
//

import SwiftUI

struct GameStateInformationView: View {
    let primaryText: String
    let secondaryText: String
    
    var body: some View {
        VStack {
            Text(primaryText)
                .font(.title.weight(.semibold))
            Text(secondaryText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    GameStateInformationView(primaryText: "Score: ???", secondaryText: "StringPlayed games: ???/10")
}
