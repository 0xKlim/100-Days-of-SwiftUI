//
//  GameBarView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 13.08.2026.
//

import SwiftUI

struct GameBarView: View {
    let areRolled: Bool
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
                .disabled(areRolled)
            
            
            Button(areRolled ? "Next" : "Roll",systemImage: areRolled ? "arrow.right" : "", action:  areRolled ? onNext : onRoll)
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
    }
}

#Preview {
    GameBarView(areRolled: false) {
        
    } onNext: {
        
    } onRoll: {
        
    }

}
