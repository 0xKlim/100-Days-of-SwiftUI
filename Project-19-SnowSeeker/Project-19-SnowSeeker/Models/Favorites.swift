//
//  Favorites.swift
//  Project-19-SnowSeeker
//
//  Created by Vladislav on 10.09.2026.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"

    init() {
        // load our saved data
        if let savedData = UserDefaults.standard.data(forKey: key) {
            if let data = try? JSONDecoder().decode(Set<String>.self, from: savedData) {
                resorts = data
                return
            }
        }
        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(data, forKey: key)
        }
//        do {
//            let data = try JSONEncoder().encode(resorts)
//            UserDefaults.standard.set(data, forKey: key)
//        } catch {
//            fatalError("Something went wrong, while ecndoding favorites")
//        }
    
    }
}
