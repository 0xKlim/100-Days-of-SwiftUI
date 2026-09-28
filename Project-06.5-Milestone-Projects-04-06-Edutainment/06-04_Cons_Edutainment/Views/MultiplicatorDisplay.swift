//
//  MultiplicatorDisplay.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 24.09.2026.
//

import SwiftUI

struct MultiplicatorDisplay: View {
    let condition: String
    let answer: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text("How much is…")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
                .padding(.vertical)
            
            HStack {
                Text(condition)
                    .font(.system(size: 28, weight: .medium, design: .rounded))
                
                Text(answer)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
            .monospacedDigit()
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .glassEffect(in: .rect(cornerRadius: 20))
    }
}

#Preview {
    MultiplicatorDisplay(condition: "0 x 0 =", answer: "0")
}
