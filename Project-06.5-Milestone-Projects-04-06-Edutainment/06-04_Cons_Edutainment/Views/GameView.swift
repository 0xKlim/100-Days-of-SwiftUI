//
//  GameView.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 24.09.2026.
//

import SwiftUI

struct GameView: View {
    let questions: [Question]
    let onEndGame: () -> Void
    
    @State private var currentQuestion = 0
    @State private var userAnswer = ""
    @State private var score = 0
    
    @State private var isCorrect = false
    @State private var shadowRadius = 0.0
    @State private var isAnimating = false
    
    @State private var showingFinishAlert = false
    
    var userAnswerFormatted: String {
        userAnswer.isEmpty ? "0" : userAnswer
    }
    
    var body: some View {
        VStack {
            Spacer()
            MultiplicatorDisplay(condition: questions[currentQuestion].condition, answer: userAnswerFormatted)
                .shadow(color: shadowRadius == 0 ? .clear : (isCorrect ? .green : .red), radius: shadowRadius)
            
            Spacer()
            GameStatusView(current: currentQuestion + 1, total: questions.count)
            
            KeyboardView(onTap: addNumber(_:), onDelete: removeLastNumber, onSubmit: checkAnswer)
                .disabled(isAnimating)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 0) {
                    Text("Score: ")
                    Text("\(score)")
                        .monospacedDigit()
                }
                .font(.system(size: 18, weight: .medium, design: .rounded))
            }
        }
        .alert("Finish!", isPresented: $showingFinishAlert) {
            Button("Try again") {
                onEndGame()
            }
        } message: {
            Text("Your score \(score) out of \(questions.count)")
        }
    }
    
    func addNumber(_ number: String) {
        guard !isAnimating else { return }
        
        userAnswer.append(number)
        userAnswer.trimPrefix("0")
        
        if userAnswer.count > 3 {
            userAnswer.removeLast()
        }
    }
    
    func removeLastNumber() {
        guard !isAnimating else { return }
        
        if !userAnswer.isEmpty {
            userAnswer.removeLast()
        }
    }
    
    func checkAnswer() {
        guard !isAnimating else { return }
        
        isCorrect = userAnswerFormatted == questions[currentQuestion].answer
        if isCorrect {
            score += 1
        }
        
        isAnimating = true
        
        withAnimation(.easeInOut.repeatCount(isCorrect ? 1 : 3, autoreverses: true)) {
            shadowRadius = 30
        } completion: {
            withAnimation(.easeInOut.repeatCount(1)) {
                shadowRadius = 0
            } completion: {
                isAnimating = false
                userAnswer.removeAll()
                countGame()
            }
        }
    }
    
    func countGame() {
        if currentQuestion >= questions.count - 1{
            showingFinishAlert = true
        } else {
            currentQuestion += 1
        }
    }
}

#Preview {
    GameView(questions: [Question(multiplicand: 2, multiplier: 2)]) {
        
    }
}
