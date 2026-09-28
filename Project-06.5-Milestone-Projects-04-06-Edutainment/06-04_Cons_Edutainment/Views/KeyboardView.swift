//
//  KeyboardView.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 23.09.2026.
//

import SwiftUI

struct KeyboardView: View {
    let onTap: (String) -> Void
    let onDelete: () -> Void
    let onSubmit: () -> Void
    
    let columns = Array(repeating: GridItem(spacing: 8), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(1..<10, id: \.self) { num in
                KeyboardButtonView(String(num)) {
                    onTap(String(num))
                }
            }
            
            KeyboardButtonView(systemImage: "delete.left") {
                onDelete()
            }
            
            KeyboardButtonView("0") {
                onTap("0")
            }
            
            KeyboardButtonView(systemImage: "return") {
                onSubmit()
            }
        }
    }
}

#Preview {
    KeyboardView { num in
        print(num)
    } onDelete: {
        print("Delete")
    } onSubmit: {
        print("Submit")
    }

}
