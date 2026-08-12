//
//  Roll.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 07.08.2026.
//

import Foundation
import SwiftData

@Model
class Roll: Identifiable {
    var id: UUID
    var diceResults: [Int]
    
    var diceSum: Int {
        diceResults.reduce(0, +)
    }
    
    init(diceResults: [Int]) {
        self.id = UUID()
        self.diceResults = diceResults
    }
}
