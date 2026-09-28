//
//  ButtonView.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 23.09.2026.
//

import SwiftUI

struct KeyboardButtonView: View {
    let text: String?
    let systemImage: String?
    let onTap: () -> Void
    
    init(_ text: String?, onTap: @escaping () -> Void) {
        self.text = text
        self.systemImage = nil
        self.onTap = onTap
    }
    
    init(systemImage: String?, onTap: @escaping () -> Void) {
        self.text = nil
        self.systemImage = systemImage
        self.onTap = onTap
    }
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Group {
                if let text {
                    Text(text)
                        .font(.system(size: 28, weight: .medium, design: .rounded))
//                        .font(.system(.title, design: .rounded, weight: .medium))
                        .monospacedDigit()
                } else if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 30, weight: .medium, design: .rounded))
//                        .font(.system(.title, design: .rounded, weight: .medium))
                        
                        
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.glass)
    }
}

#Preview {
    KeyboardButtonView("1") { }
}
