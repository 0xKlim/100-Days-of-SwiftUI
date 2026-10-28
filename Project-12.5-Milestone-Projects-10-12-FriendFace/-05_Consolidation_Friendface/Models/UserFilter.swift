//
//  UserFilter.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 28.10.2026.
//

import Foundation

enum UserFilter: String, Identifiable, CaseIterable {
    case all = "All"
    case online = "Online"
    case offline = "Offline"
    
    var id: Self { self }
}
