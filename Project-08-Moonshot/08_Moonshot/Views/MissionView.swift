//
//  MissionView.swift
//  08_Moonshot
//
//  Created by Vladislav on 01.10.2026.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.6
                    }
                    .padding(.top)
                
                Text(mission.formattedLaunchDate)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    CustomDivider()
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                }
                .padding(.horizontal)
                
                CrewView(mission: mission, astronauts: astronauts)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission = missions[1]
    
    return NavigationStack {
        MissionView(mission: mission, astronauts: astronauts)
            .navigationDestination(for: Astronaut.self) { astronaut in
                AstronautView(astronaut: astronaut)
            }
            .preferredColorScheme(.dark)
    }
}
