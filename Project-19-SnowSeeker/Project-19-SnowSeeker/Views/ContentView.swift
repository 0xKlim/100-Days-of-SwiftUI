//
//  ContentView.swift
//  Project-19-SnowSeeker
//
//  Created by Vladislav on 14.08.2026.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortCriteria: SortCriteria = .none
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText)}
        }
    }
    
    var sortedResorts: [Resort] {
        switch sortCriteria {
        case .none:
            filteredResorts
        case .alphabetic:
            filteredResorts.sorted(by: {$0.name.localizedStandardCompare($1.name) == .orderedAscending})
        case .alphabeticInversed:
            filteredResorts.sorted(by: {$0.name.localizedStandardCompare($1.name) == .orderedDescending})
        case .country:
            filteredResorts.sorted(by: {$0.country.localizedStandardCompare($1.country) == .orderedAscending})
        case .countryInversed:
            filteredResorts.sorted(by: {$0.country.localizedStandardCompare($1.country) == .orderedDescending})
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for resort")
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortCriteria) {
                        ForEach(SortCriteria.allCases) { criteria in
                            Text(criteria.rawValue)
                            
                        }
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .preferredColorScheme(.dark)
        .environment(favorites)
    }
    
    enum SortCriteria: String, CaseIterable, Identifiable {
        case none = "Default"
        case alphabetic = "Alphabetic A-Z"
        case alphabeticInversed = "Alphabetic Z-A"
        case country = "Country A-Z"
        case countryInversed = "Country Z-A"
        
        var id: Self { self }
    }
}

#Preview {
    ContentView()
}

