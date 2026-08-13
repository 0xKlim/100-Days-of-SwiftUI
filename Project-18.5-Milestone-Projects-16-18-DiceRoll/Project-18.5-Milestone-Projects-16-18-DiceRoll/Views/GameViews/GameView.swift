//
//  GameView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 10.08.2026.
//

import Combine
import CoreHaptics
import SwiftData
import SwiftUI

struct GameView: View {
    @AppStorage(AppStorageKeys.numberOfFaces) var numberOfFaces = 6
    @AppStorage(AppStorageKeys.numberOfDice) var numberOfDice = 2
    
    @Query(sort: \Player.name) var players: [Player]
    @Environment(\.modelContext) var modelContext
    
    @State private var activePlayerID: UUID?
    @State private var rolledDice = [Int]()
    @State private var areRolled = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timeCounter = 10
    
    private var rolledSum: Int {
        rolledDice.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            if !players.isEmpty {
                PlayersQueueView(players: players, activePlayerID: activePlayerID)
                    .padding(.bottom)
                
                DiceView(value: rolledSum, color: .green)
                    .font(.largeTitle)
                    .aspectRatio(1.0, contentMode: .fit)
                    .containerRelativeFrame(.horizontal) { length, _ in
                        length * 0.25
                    }
                    .padding(.vertical)
                
                RolledDiceView(rolledDice: rolledDice)
                    .onReceive(timer) { time in
                        if timeCounter > 0 {
                            timeCounter -= 1
                            animatingRoll()
                        }
                    }
                
                Spacer()
               
                GameBarView(areRolled: areRolled, onSkip: changePlayer, onNext: nextMove, onRoll: roll)
                    .padding(.vertical, 24)
                
            } else {
                NoPlayersView {
                    modelContext.insert(Player.defaultPlayer(number: 0))
                    modelContext.insert(Player.defaultPlayer(number: 1))
                }
            }
        }
        .onAppear(perform: checkPlayers)
        .onChange(of: players, checkPlayers)
    }
    
    func checkPlayers() {
        if activePlayerID == nil {
            activePlayerID = players.first?.id
        }
        
        if !players.contains(where: {$0.id == activePlayerID}) {
            changePlayer()
        }
    }
    
    func changePlayer() {
        activePlayerID = players.nextPlayer(after: activePlayerID)?.id
    }
    
    func nextMove() {
        saveRolledResult()
        changePlayer()
        rolledDice.removeAll()
        areRolled = false
    }
    
    func roll() {
        for _ in 0..<numberOfDice {
            let value = Int.random(in: 1...numberOfFaces)
            withAnimation {
                rolledDice.append(value)
            }
        }
        
        timeCounter = 10
    }
    
    func animatingRoll() {
        guard rolledDice.count >= numberOfDice else { return }
        
        for i in 0..<numberOfDice {
            let value = Int.random(in: 1...numberOfFaces)
            withAnimation(.easeIn(duration: 0.05)) {
                rolledDice[i] = value
            }
        }
        
        areRolled = true
    }
    
    func saveRolledResult() {
        players.first(where: {$0.id == activePlayerID})?.rolls.append(Roll(diceResults: rolledDice))
    }
}

#Preview {
    GameView()
}
