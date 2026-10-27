//
//  UserRowView.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 27.10.2026.
//

import SwiftUI

struct UserRowView: View {
    let name: String
    let isActive: Bool
    
    var body: some View {
        HStack {
            Text(name)
            if isActive {
                UserOnlineStatusView(isActive: isActive)
            }
        }
    }
}

#Preview {
    UserRowView(name: "John", isActive: true)
}
