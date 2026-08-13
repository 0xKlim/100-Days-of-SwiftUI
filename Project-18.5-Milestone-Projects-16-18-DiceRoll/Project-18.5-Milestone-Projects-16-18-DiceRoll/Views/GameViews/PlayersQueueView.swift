//
//  PlayersQueueView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 11.08.2026.
//

import SwiftUI

struct PlayersQueueView: View {
    let players: [Player]
    let activePlayerID: UUID?
    
    @State private var position = ScrollPosition()
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 0) {
                ClearSpacesView()
                
                ForEach(players) { player in
                    VStack {
                        Text(player.name)
                            .font(.title2)
                    }
                    .padding()
                    .containerRelativeFrame(.horizontal) { size, _ in
                        size * 0.5
                    }
                    .background(isPlayerActive(player) ? .orange.opacity(0.6) : .black.opacity(0.3))
                    .opacity(isPlayerActive(player) ? 1 : 0.3)
                    .clipShape(.capsule)
                    .scaleEffect(isPlayerActive(player) ? 1 : 0.7)
                    .animation(.default, value: activePlayerID)
                    .visualEffect { content, proxy in
                        content
                            .rotation3DEffect(.degrees((-proxy.frame(in: .global).midX + proxy.size.width) / 10), axis: (x: 0, y: 1, z: 0))
                    }
                    .tag(player.id)
                }
                
                ClearSpacesView()
            }
            .scrollTargetLayout()
        }
        .scrollPosition($position, anchor: .center)
        .scrollDisabled(true)
        .scrollClipDisabled()
        .onChange(of: activePlayerID) {
            updateCurrentPlayer()
        }
    }
    
    func updateCurrentPlayer() {
        guard let activePlayerID else { return }
        
        withAnimation(.bouncy) {
            position.scrollTo(id: activePlayerID)
        }
    }
    
    func isPlayerActive(_ player: Player) -> Bool {
        player.id == activePlayerID
    }
}

#Preview {
    PlayersQueueView(players: [Player](), activePlayerID: UUID())
}
