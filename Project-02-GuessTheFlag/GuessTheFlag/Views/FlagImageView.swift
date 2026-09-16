//
//  FlagImageView.swift
//  GuessTheFlag
//
//  Created by Vladislav on 16.09.2026.
//

import SwiftUI

struct FlagImageView: View {
    let name: String
    
    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImageView(name: "US")
}
