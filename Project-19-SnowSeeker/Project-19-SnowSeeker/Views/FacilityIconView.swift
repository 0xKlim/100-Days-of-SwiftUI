//
//  FacilityIconView.swift
//  Project-19-SnowSeeker
//
//  Created by Vladislav on 10.09.2026.
//

import SwiftUI

struct FacilityIconView: View {
    let name: String
    let iconAccessibilityLabel: String
    
    var body: some View {
        Image(systemName: name)
            .accessibilityLabel(iconAccessibilityLabel)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    FacilityIconView(name: "plus", iconAccessibilityLabel: "plus")
}
