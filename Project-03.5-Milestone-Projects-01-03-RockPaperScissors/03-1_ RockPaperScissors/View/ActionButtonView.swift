//
//  ActionButtonView.swift
//  03-1_ RockPaperScissors
//
//  Created by Vladislav on 16.09.2026.
//

import SwiftUI

struct ActionButtonView: View {
    let name: String
    let onTapped: () -> Void
    
    init(_ name: String, onTapped: @escaping () -> Void) {
        self.name = name
        self.onTapped = onTapped
    }
    
    var body: some View {
        Button {
            onTapped()
        } label: {
            Text(name)
                .font(.headline)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.mint)
        .shadow(radius: 5)

    }
}

#Preview {
    ActionButtonView("Rock") {
        
    }
}
