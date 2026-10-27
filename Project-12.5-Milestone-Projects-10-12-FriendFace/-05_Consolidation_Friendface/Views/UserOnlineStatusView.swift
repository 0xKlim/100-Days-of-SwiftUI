//
//  UserOnlineStatusView.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 27.10.2026.
//

import SwiftUI

struct UserOnlineStatusView: View {
    let isActive: Bool
    let indicator: Bool
    let text: Bool
    
    init(isActive: Bool, indicator: Bool = true, text: Bool = true) {
        self.isActive = isActive
        self.indicator = indicator
        self.text = text
    }
    
    var body: some View {
        HStack( spacing: 4) {
            if indicator {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(isActive ? .green : .black.opacity(0))
            }
            if text {
                Text(isActive ? "Online" : "")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    UserOnlineStatusView(isActive: true)
}
