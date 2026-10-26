//
//  _2_SwiftDataProjectApp.swift
//  12_SwiftDataProject
//
//  Created by Vladislav on 13.05.2026.
//

import SwiftUI
import SwiftData

@main
struct _2_SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
