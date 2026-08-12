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
    
    @State private var currentPlayer = 0
    @State private var rolledDice = [Int]()
    @State private var areRolled = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timeCounter = 10
    
    private var rolledSum: Int {
        rolledDice.reduce(0, +)
    }
    
    private var safeCurrentPlayer: Int {
        min(currentPlayer, players.count - 1)
        
    }
    
    var body: some View {
        VStack {
            if !players.isEmpty {
                PlayersQueueView(players: players, currentPlayer: safeCurrentPlayer)
                    .padding(.bottom)
                    .onChange(of: players, checkPlayers)
                
                DiceView(value: rolledSum, color: .black)
                    .font(.largeTitle)
                    .aspectRatio(1.5, contentMode: .fit)
                    .containerRelativeFrame(.horizontal) { length, _ in
                        length * 0.33
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
               
                HStack(spacing: 0) {
                    Button("Skip",action: changePlayer)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.circle)
                        .containerRelativeFrame(.horizontal) { length, _ in
                            length * 0.3
                        }
                        .disabled(areRolled)
                    
                    
                    Button(areRolled ? "Next" : "Roll",systemImage: areRolled ? "arrow.right" : "", action:  areRolled ? changePlayer : roll)
                        .foregroundStyle(.white)
                        .padding()
                        .containerRelativeFrame(.horizontal) { length, _ in
                            length * 0.4
                        }
                        .background(areRolled ? .green : .blue)
                        .clipShape(.buttonBorder)
                        .sensoryFeedback(.start, trigger: areRolled)
                    
                    Color.clear
                        .frame(height: 0)
                        .containerRelativeFrame(.horizontal) { length, _ in
                            length * 0.3
                        }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                
            } else {
                Text("Plaease add player in settings first")
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear(perform: checkPlayers)

    }
    
    func checkPlayers() {
        if currentPlayer >= players.count {
            currentPlayer = 0
        }
        
        if players.isEmpty {
            modelContext.insert(Player.defaultPlayer(number: players.count))
            modelContext.insert(Player.defaultPlayer(number: players.count + 1))
            modelContext.insert(Player.defaultPlayer(number: players.count + 2))
        }
    }
    
    func changePlayer() {
        saveRolledResult()
        
        if currentPlayer >= players.count - 1 {
            currentPlayer = 0
        } else {
            currentPlayer += 1
        }
        
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
        players[safeCurrentPlayer].rolls.append(Roll(diceResults: rolledDice))
    }
}

#Preview {
    GameView()
}
