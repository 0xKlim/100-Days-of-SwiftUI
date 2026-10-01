//
//  CrewView.swift
//  08_Moonshot
//
//  Created by Vladislav on 01.10.2026.
//

import SwiftUI

struct CrewView: View {
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomDivider()
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
        }
        .padding(.horizontal)
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.white, lineWidth: 1)
                                }
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.trailing)
                        .background(.lightBackground)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.trailing)
                    }
                }
            }
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
    }
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission = missions[1]
    
    return CrewView(mission: mission, astronauts: astronauts)
        .preferredColorScheme(.dark)
}
