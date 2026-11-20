//
//  ContentView-ViewModel.swift
//  14_BucketList
//
//  Created by Vladislav on 18.11.2026.
//

import CoreLocation
import Foundation
import LocalAuthentication

extension ContentView {
    @MainActor
    @Observable
    class ViewModel {
        private let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        var isUnlocked = false
        
        private(set) var locations: [Location]
        var selectedPlace: Location?

        var mapMode: MapMode = .standard
        
        var showingAuthenticationErrorAlert = false
        var authenticationErrorTitle = ""
        var authenticationErrorMessage = ""
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }
        
        func showAuthenticationErrorAlert(title: String, message: String) {
            authenticationErrorTitle = title
            authenticationErrorMessage = message
            showingAuthenticationErrorAlert = true
        }
        
        func authenticate() async {
            let context = LAContext()
            var error: NSError?
            
            guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
                showAuthenticationErrorAlert(title: "Biometrics unavailable", message: "This device doesn't support biometrics authentication.")
                return
            }
            
            let reason = "Please authenticate yourself to unlock your places."
            
            do {
                isUnlocked = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
            } catch let laError as LAError where laError.code == .userCancel {
                // user cancel authentication
            } catch {
                showAuthenticationErrorAlert(title: "Failed, try again", message: error.localizedDescription)
            }
        }
        
        enum MapMode: String, Identifiable, CaseIterable {
            case standard = "Standard"
            case hybrid = "Hybrid"
            case imagery = "Imagery"
            
            var id: Self { self }
        }
    }
}
