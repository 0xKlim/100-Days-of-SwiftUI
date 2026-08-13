//
//  Player-Extension.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 13.08.2026.
//

import Foundation

extension Array where Element == Player {
    func nextPlayer(after currentId: UUID?) -> Player? {
        // check that array isn't empty
        guard !isEmpty else { return nil }
        
        // find current player, if that don't exist - return first one
        guard let currentId, let currentIndex = firstIndex(where: {$0.id == currentId}) else { return first}
        
        // move to the next player
        let nextIndex = (currentIndex + 1) % count
        return self[nextIndex]
    }
}
