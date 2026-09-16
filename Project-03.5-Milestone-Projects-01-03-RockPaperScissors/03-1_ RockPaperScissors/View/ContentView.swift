//
//  ContentView.swift
//  03-1_ RockPaperScissors
//
//  Created by Vladislav on 14.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldWin = Bool.random()
    @State private var appChoice: Move = .allCases.randomElement() ?? .rock
    @State private var score = 0
    @State private var roundsCounter = 0
    @State private var showingFinishGameAlert = false
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                
                VStack {
                    GameTaskView(move: appChoice.rawValue, shouldWin: shouldWin)
                    
                    HStack {
                        ForEach(Move.allCases) { move in
                            ActionButtonView(move.rawValue) {
                                moveTapped(move)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                
                Spacer()
                
                GameStateInformationView(primaryText: "Score: \(score)", secondaryText: "Played games: \(roundsCounter)/10")
                
                Spacer()
            }
        }
        .alert("Finish!", isPresented: $showingFinishGameAlert) {
            Button("New Game", action: resetGame)
        } message: {
            Text("Your score is \(score) out of \(roundsCounter) points!")
        }
    }
    
    func moveTapped(_ move: Move) {
        checkMoveCorrectness(move)
        
        roundsCounter += 1
        
        if roundsCounter >= 10 {
            showingFinishGameAlert = true
        }
        
        startNewRound()
    }
    
    func checkMoveCorrectness(_ move: Move) {
        if move == appChoice.requiredMove(toWin: shouldWin) {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func startNewRound() {
        shouldWin = Bool.random()
        appChoice = .allCases.randomElement() ?? .rock
    }
    
    func resetGame() {
        score = 0
        roundsCounter = 0
        startNewRound()
    }
    
    enum Move: String, CaseIterable, Identifiable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
        
        var id: Self { self }
        
        var winningMove: Self {
            switch self {
            case .rock: return .paper
            case .paper: return .scissors
            case .scissors: return .rock
            }
        }
        
        var losingMove: Self {
            switch self {
            case .rock: return .scissors
            case .paper: return .rock
            case .scissors: return .paper
            }
        }
        
        func requiredMove(toWin: Bool) -> Move {
            toWin ? winningMove : losingMove
        }
    }
}

#Preview {
    ContentView()
}
