//
//  BackgroundView.swift
//  03-1_ RockPaperScissors
//
//  Created by Vladislav on 16.09.2026.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .green, location: 0.2),
                .init(color: .yellow, location: 0.2),
            ], center: .leading, startRadius: 200, endRadius: 700)
            
            RadialGradient(stops: [
                .init(color: .red, location: 0.2),
                .init(color: .clear, location: 0.2),
            ], center: .topTrailing, startRadius: 200, endRadius: 700)
            
            RadialGradient(stops: [
                .init(color: Color(red: 0, green: 0, blue: 1), location: 0.2),
                .init(color: .clear, location: 0.2),
            ], center: .bottomTrailing, startRadius: 200, endRadius: 700)
        }
    }
}

#Preview {
    BackgroundView()
}
