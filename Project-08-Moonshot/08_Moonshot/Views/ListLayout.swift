//
//  ListLayout.swift
//  08_Moonshot
//
//  Created by Vladislav on 01.10.2026.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink(value: mission) {
                MissionRowItem(mission: mission)
            }
            .listRowInsets(.vertical, 8)
            .listRowBackground(Color.darkBackground)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

private struct MissionRowItem: View {
    let mission: Mission
    
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(8)
            
            HStack {
                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.leading)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    NavigationStack {
        ListLayout(missions: missions, astronauts: astronauts)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
