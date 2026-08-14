//
//  GameBarView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 13.08.2026.
//

import SwiftUI

struct GameBarView: View {
    let isRolled: Bool
    let onSkip: () -> Void
    let onNext: () -> Void
    let onRoll: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button("Skip",action: onSkip)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.circle)
                .containerRelativeFrame(.horizontal) { length, _ in
                    length * 0.3
                }
                .shadow(radius: 10)
                .disabled(isRolled)
            
            
            Button(isRolled ? "Next" : "Roll",systemImage: isRolled ? "arrow.right" : "", action:  isRolled ? onNext : onRoll)
                .foregroundStyle(.white)
                .padding()
                .containerRelativeFrame(.horizontal) { length, _ in
                    length * 0.4
                }
                .background(isRolled ? .green : .blue)
                .clipShape(.buttonBorder)
                .shadow(color: isRolled ? .green.opacity(0.5) : .blue.opacity(0.5), radius: 10)
                .sensoryFeedback(.start, trigger: isRolled)
            
            Color.clear
                .frame(height: 0)
                .containerRelativeFrame(.horizontal) { length, _ in
                    length * 0.3
                }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    GameBarView(isRolled: false) {
        
    } onNext: {
        
    } onRoll: {
        
    }

}
