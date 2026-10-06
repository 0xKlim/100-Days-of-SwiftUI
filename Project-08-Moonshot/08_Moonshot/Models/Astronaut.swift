//
//  Astronaut.swift
//  08_Moonshot
//
//  Created by Vladislav on 30.09.2026.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
