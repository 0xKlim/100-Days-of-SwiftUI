//
//  Facility.swift
//  Project-19-SnowSeeker
//
//  Created by Vladislav on 10.09.2026.
//

import Foundation

struct Facility: Identifiable {
    let id = UUID()
    var name: String
    
    private let icons = [
            "Accommodation": "house",
            "Beginners": "1.circle",
            "Cross-country": "map",
            "Eco-friendly": "leaf.arrow.circlepath",
            "Family": "person.3"
        ]
    
    private let descriptions = [
        "Accommodation": "This resort has popular on-site accommodation.",
        "Beginners": "This resort has lots of ski schools.",
        "Cross-country": "This resort has many cross-country ski routes.",
        "Eco-friendly": "This resort has won an award for environmental friendliness.",
        "Family": "This resort is popular with families."
    ]
    
    var description: String {
        descriptions[name] ?? "Information about this facility is currently unavailable."
    }
    
    var iconName: String {
        if let iconName = icons[name] {
            iconName
        } else {
            "questionmark.square.dashed"
        }
    }
    
    var iconAccessibilityLabel: String {
        if let iconName = icons[name] {
            iconName
        } else {
            "Information about this facility is currently unavailable."
        }
    }
}
