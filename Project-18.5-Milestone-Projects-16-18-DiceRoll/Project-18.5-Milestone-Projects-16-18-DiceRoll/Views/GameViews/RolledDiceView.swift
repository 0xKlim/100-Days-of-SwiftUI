//
//  RolledDiceView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 12.08.2026.
//

import SwiftUI

struct RolledDiceView: View {
    @AppStorage(AppStorageKeys.numberOfDice) var numberOfDice = 2
    
    let rolledDice: [Int]
    
    let spacing: CGFloat = 12
    
    var columns: Array<GridItem> {
        Array(repeating: GridItem(.flexible(minimum: 50, maximum: 80), spacing: spacing), count: min(numberOfDice, 5))
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(rolledDice.indices, id: \.self) { index in
                DiceView(value: rolledDice[index], color: .blue)
                    .font(.title2)
                    .aspectRatio(1.0, contentMode: .fit)
            }
        }
    }
}

#Preview {
    var arr: [Int] {
        var arr = [Int]()
        for _ in 1..<11 {
            arr.append(Int.random(in: 1...8))
        }
        return arr
    }
    
    RolledDiceView(rolledDice: arr)
}
