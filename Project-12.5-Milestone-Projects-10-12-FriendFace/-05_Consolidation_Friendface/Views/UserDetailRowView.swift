//
//  UserDetailRowView.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 27.10.2026.
//

import SwiftUI

struct UserDetailRowView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.callout.weight(.semibold))
            Text(description)
                .font(.default)
                .foregroundStyle(.primary.opacity(0.7))
        }
    }
}

#Preview {
    UserDetailRowView(title: "Address", description: "Some Address")
}
