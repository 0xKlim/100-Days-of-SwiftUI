//
//  Player.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 07.08.2026.
//

import Foundation
import SwiftData

@Model
class Player: Identifiable {
    var id: UUID
    var name: String 
    var rolls: [Roll]
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.rolls = [Roll]()
    }
    
    init(name: String, rolls: [Roll]) {
        self.id = UUID()
        self.name = name
        self.rolls = rolls
    }
    
    static func defaultPlayer(number: Int?) -> Player {
        if let number {
            return Player(name: "Player \(number + 1)")
        } else {
            return Player(name: "Player 1")
        }
    }
}
