//
//  _05_Consolidation_FriendfaceApp.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 25.05.2026.
//

import SwiftUI
import SwiftData

@main
struct _05_Consolidation_FriendfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
