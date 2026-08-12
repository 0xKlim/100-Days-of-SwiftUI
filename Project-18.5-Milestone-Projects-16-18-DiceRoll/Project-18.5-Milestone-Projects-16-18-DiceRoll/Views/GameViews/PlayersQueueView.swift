//
//  PlayersQueueView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 11.08.2026.
//

import SwiftUI

struct PlayersQueueView: View {
    let players: [Player]
    let currentPlayer: Int
    
    @State private var position = ScrollPosition()
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 0) {
                ClearSpacesView()
                
                ForEach(players) { player in
                    VStack {
                        Image(systemName: "star")
                        Text(player.name)
                    }
                    .tag(player.id)
                    .padding()
                    .containerRelativeFrame(.horizontal) { size, _ in
                        size * 0.5
                    }
                    .background(isPlayerActive(player) ? .orange.opacity(0.6) : .black.opacity(0.3))
                    .opacity(isPlayerActive(player) ? 1 : 0.3)
                    .clipShape(.capsule)
                    .scaleEffect(isPlayerActive(player) ? 1 : 0.7)
                    .animation(.default, value: currentPlayer)
                    .visualEffect { content, proxy in
                        content
                            .rotation3DEffect(.degrees((-proxy.frame(in: .global).midX + proxy.size.width) / 10), axis: (x: 0, y: 1, z: 0))
                    }
                }
                
                ClearSpacesView()
            }
            .scrollTargetLayout()
        }
        .scrollPosition($position, anchor: .center)
        .scrollDisabled(true)
        .scrollClipDisabled()
        .onChange(of: currentPlayer) {
            updateCurrentPlayer()
        }
    }
    
    func updateCurrentPlayer() {
        withAnimation(.bouncy) {
            position.scrollTo(id: players[currentPlayer].id)
        }
    }
    
    func isPlayerActive(_ player: Player) -> Bool {
        player.id == players[currentPlayer].id
    }
}

#Preview {
    PlayersQueueView(players: [Player](), currentPlayer: 0)
}
