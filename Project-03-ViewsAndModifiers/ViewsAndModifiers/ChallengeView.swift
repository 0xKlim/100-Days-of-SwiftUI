//
//  ChallengeView.swift
//  ViewsAndModifiers
//
//  Created by Vladislav on 16.09.2026.
//

import SwiftUI

struct ChallengeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .prominentTitle()
    }
}

#Preview {
    ChallengeView()
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}
