//
//  GameTaskView.swift
//  03-1_ RockPaperScissors
//
//  Created by Vladislav on 16.09.2026.
//

import SwiftUI

struct GameTaskView: View {
    let move: String
    let shouldWin: Bool
    
    var body: some View {
        Text("You should:")
            .font(.subheadline)
        
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(shouldWin ? "Win" : "Lose")
                Text("the")
                    .font(.title3)
            }
            Text(move)
        }
        .font(.title.weight(.semibold))
        .padding(.vertical)
        
        Text("Guess the move")
            .foregroundStyle(.secondary)
            .font(.caption)
    }
}

#Preview {
    GameTaskView(move: "Scissors", shouldWin: true)
}
