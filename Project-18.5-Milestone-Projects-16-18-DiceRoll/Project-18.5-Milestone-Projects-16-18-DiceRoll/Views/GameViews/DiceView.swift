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
            Text(value.formatted())
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(color)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.8), lineWidth: 8)
                        .blur(radius: 4)
                        
                }
                .clipShape(.rect(cornerRadius: 16))
        }
//        .shadow(color: .black, radius: 10)
    }
    
    
}

#Preview {
    DiceView(value: 6, color: .black)
        .font(.title)
        .containerRelativeFrame(.horizontal) { lenght, _ in
            lenght * 0.2
        }
}
