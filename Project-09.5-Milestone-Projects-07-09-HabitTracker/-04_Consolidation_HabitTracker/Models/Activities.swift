//
//  Activities.swift
//  -04_Consolidation_HabitTracker
//
//  Created by Vladislav on 07.10.2026.
//

import Foundation

@Observable
class Activities {
    var items: [ActivityItem] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
    
    private let key = "activities"
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode([ActivityItem].self, from: saved) {
                items = decoded
                return
            }
        }
        
        items = []
    }
}
