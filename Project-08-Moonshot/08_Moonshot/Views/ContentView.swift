//
//  ContentView.swift
//  08_Moonshot
//
//  Created by Vladislav on 27.04.2026.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGridLayout = true
      
    var body: some View {
        NavigationStack {
            Group {
                if showingGridLayout {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Layout", systemImage: showingGridLayout ? "list.bullet" : "rectangle.grid.2x2") {
                    showingGridLayout.toggle()
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationDestination(for: Astronaut.self) { astronaut in
                AstronautView(astronaut: astronaut)
            }
        }
    }
}

#Preview {
    ContentView()
}
