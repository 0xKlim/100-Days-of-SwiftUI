//
//  ActivityItem.swift
//  -04_Consolidation_HabitTracker
//
//  Created by Vladislav on 07.10.2026.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var completionCount: Int
    
    init(id: UUID = UUID(), name: String, description: String, completionCount: Int = 0) {
        self.id = id
        self.name = name
        self.description = description
        self.completionCount = completionCount
    }
    
    #if DEBUG
    static let example = ActivityItem(name: "Example name", description: "Example desctiption")
    #endif
}
