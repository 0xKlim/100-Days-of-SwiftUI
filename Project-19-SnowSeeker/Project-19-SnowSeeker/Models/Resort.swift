//
//  Resort.swift
//  Project-19-SnowSeeker
//
//  Created by Vladislav on 08.09.2026.
//

import Foundation

struct Resort: Codable, Hashable, Identifiable {
//    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
//    static let example = allResorts[0]
    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}
