//
//  Project_18_5_Milestone_Projects_16_18_DiceRollApp.swift
//  Project-18.5-Milestone-Projects-16-18-DiceRoll
//
//  Created by Vladislav on 07.08.2026.
//

import SwiftUI
import SwiftData

@main
struct Project_18_5_Milestone_Projects_16_18_DiceRollApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Player.self)
    }
}
