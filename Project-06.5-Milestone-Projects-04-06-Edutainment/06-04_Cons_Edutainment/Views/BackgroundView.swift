//
//  BackgroundView.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 23.09.2026.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(stops: [
            .init(color: .orange, location: 0),
            .init(color: .blue, location: 0.4),
            .init(color: .red, location: 1.2),
        ], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    BackgroundView()
        .ignoresSafeArea()
}
