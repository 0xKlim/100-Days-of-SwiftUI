//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vladislav on 10.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingFinal = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gamesCounter = 0
    @State private var turnAmount = 0.0
    @State private var chosenFlag = -1
    
    private var areAnyFlagChosen: Bool {
        chosenFlag != -1
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImageView(name: countries[number])
                        }
                        .opacity(!areAnyFlagChosen || isFlagChosen(number) ? 1 : 0.25)
                        .scaleEffect(!areAnyFlagChosen ? 1 : isFlagChosen(number) ? 1.1 : 0.8)
                        .rotation3DEffect(isFlagChosen(number) ? .degrees(turnAmount) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                        .animation(.default, value: turnAmount)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Played games: \(gamesCounter)/8")
                    .font(.subheadline.weight(.heavy))
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: countGame)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Finish! Your score is \(score)", isPresented: $showingFinal) {
            Button("Start new game", action: startNewGame)
        }
    }
    
    func isFlagChosen(_ flag: Int) -> Bool{
       flag == chosenFlag
    }
    
    func flagTapped(_ number: Int) {
//
            chosenFlag = number
            turnAmount = 360
//
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 1
        }
        
        Task {
            try? await Task.sleep(for: .seconds(0.5))
            showingScore = true
        }
        gamesCounter += 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
//
            chosenFlag = -1
            turnAmount = 0
//
    }
    
    func countGame() {
        if gamesCounter > 7 {
            showingFinal = true
        } else {
            askQuestion()
        }
    }
    
    func startNewGame() {
        score = 0
        gamesCounter = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
