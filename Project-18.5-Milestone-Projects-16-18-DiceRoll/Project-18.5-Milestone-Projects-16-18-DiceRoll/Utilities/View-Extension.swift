//
//  View-Extension.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 13.08.2026.
//

import SwiftUI

extension View {
    func appBackground() -> some View {
        self
            .background(
                LinearGradient(
                    colors: [Color(red: 0.08, green: 0.12, blue: 0.18), Color(red: 0.02, green: 0.04, blue: 0.06)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
        )
    }
}
