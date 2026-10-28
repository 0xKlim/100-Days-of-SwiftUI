//
//  Friend.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 27.10.2026.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    @Attribute(.unique) var id: UUID
    var name: String
    
    var users: [User]?
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
