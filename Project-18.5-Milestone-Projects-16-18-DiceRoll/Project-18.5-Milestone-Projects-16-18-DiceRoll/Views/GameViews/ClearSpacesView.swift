//
//  ClearSpacesForScrollView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 11.08.2026.
//

import SwiftUI

struct ClearSpacesView: View {
    var body: some View {
        Color.clear
            .containerRelativeFrame(.horizontal) { lenght, _ in
                lenght * 0.25
            }
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ClearSpacesView()
}
