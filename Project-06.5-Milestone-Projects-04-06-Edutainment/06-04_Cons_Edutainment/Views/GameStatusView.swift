//
//  GameStatusView.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 24.09.2026.
//

import SwiftUI

struct GameStatusView: View {
    let current: Int
    let total: Int
    
    var body: some View {
        Text("Question: \(current) / \(total)")
            .font(.system(size: 14, weight: .semibold, design: .rounded))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .glassEffect()
            .padding(.bottom, 8)
    }
}

#Preview {
    GameStatusView(current: 1, total: 5)
}
