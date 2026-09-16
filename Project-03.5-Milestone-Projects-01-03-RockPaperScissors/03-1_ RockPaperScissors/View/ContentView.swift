//
//  ContentView.swift
//  03-1_ RockPaperScissors
//
//  Created by Vladislav on 14.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldWin = Bool.random()
    @State private var appChoose = Int.random(in: 0...2)
    @State private var score = 0
    @State private var playedGamesCounter = 0
    @State private var showingFinishGameAlert = false
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    var correctAnswer: String {
        var answer = appChoose
        
        if shouldWin {
            answer += 1
        } else {
            answer -= 1
        }
        
        if answer > 2 {
            answer = 0
        } else if answer < 0 {
            answer = 2
        }
        
        return moves[answer]
    }
    
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
                    GameTaskView(move: moves[appChoose], shouldWin: shouldWin)
                    
                    HStack {
                        ForEach(moves, id: \.self) { move in
                            ActionButtonView(move, onTapped: moveTapped)
                        }
                    }
                    .padding(.vertical, 5)
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                
                Spacer()
                
                GameStateInformationView(primaryText: "Score: \(score)", secondaryText: "Played games: \(playedGamesCounter)/10")
                
                Spacer()
            }
        }
        .alert("Finish!", isPresented: $showingFinishGameAlert) {
            Button("New Game", action: resetGame)
        } message: {
            Text("Your score is \(score) out of \(playedGamesCounter) points!")
        }
    }
    
    func moveTapped(_ move: String) {
        checkMoveCorrectness(move)
        
        playedGamesCounter += 1
        
        if playedGamesCounter >= 10 {
            showingFinishGameAlert = true
        }
        
        askNewQuestion()
    }
    
    func checkMoveCorrectness(_ move: String) {
        if correctAnswer == move {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func askNewQuestion() {
        shouldWin = Bool.random()
        appChoose = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        playedGamesCounter = 0
        askNewQuestion()
    }
}

#Preview {
    ContentView()
}
