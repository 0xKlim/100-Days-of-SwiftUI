//
//  DiceView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 12.08.2026.
//

import SwiftUI

struct DiceView: View {
    let value: Int
    let color: Color
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(colors: [color.opacity(0.3), color.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .overlay{
                    RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: 2
                    )
                    .blur(radius: 2)
                    .shadow(color: color.opacity(0.9), radius: 4, x: 0, y: 2)
                    
                    Text(value.formatted())
                        .foregroundStyle(.white)
                }
        }
    }
    
    
}

#Preview {
    DiceView(value: 6, color: .black)
        .font(.title)
        .containerRelativeFrame(.horizontal) { lenght, _ in
            lenght * 0.2
        }
}
