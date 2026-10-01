//
//  CustomDivider.swift
//  08_Moonshot
//
//  Created by Vladislav on 01.10.2026.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
}
