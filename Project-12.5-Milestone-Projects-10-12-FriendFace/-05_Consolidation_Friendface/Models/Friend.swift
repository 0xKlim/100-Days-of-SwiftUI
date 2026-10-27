//
//  Friend.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 27.10.2026.
//

import Foundation

struct Friend: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
}
