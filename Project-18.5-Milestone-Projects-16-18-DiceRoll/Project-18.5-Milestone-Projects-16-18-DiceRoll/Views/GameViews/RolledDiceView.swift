//
//  RolledDiceView.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 12.08.2026.
//

import SwiftUI

struct RolledDiceView: View {
    let rolledDice: [Int]
    
    var rows: Int {
        var rows = rolledDice.count / 4
        if rolledDice.count % 4 > 0 {
            rows += 1
        }
        return rows
    }
    
    var body: some View {
        ForEach(0..<rows, id: \.self) { row in
            HStack {
                ForEach(row * 4 ..<  min(rolledDice.count,((row + 1) * 4)), id: \.self) { dice in
                    DiceView(value: rolledDice[dice], color: .black)
                        .font(.title)
                        .aspectRatio(1.0, contentMode: .fit)
                        .containerRelativeFrame(.horizontal) { lenght, _ in
                            lenght * 0.22
                        }
                }
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
