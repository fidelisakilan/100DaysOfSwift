//
//  MissionView.swift
//  Moonshot
//
//  Created by Fidelis Akilan on 6/27/25.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            fatalError("Missing \(member.name)")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.logoName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                Rectangle()
                    .frame(height: 2)
                    .background(.white.opacity(0.5))
                    .padding()
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                }
                .padding(.horizontal)
                Rectangle()
                    .frame(height: 2)
                    .background(.white.opacity(0.5))
                    .padding()
                VStack(alignment: .leading) {
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
            }
            .padding(.bottom)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { item in
                        NavigationLink {
                            AstronautView(astronaut: item.astronaut)
                        } label: {
                            HStack {
                                Image(item.astronaut.id)
                                    .resizable()
                                    .frame(width:104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )
                                VStack(alignment: .leading) {
                                    Text(item.astronaut.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(item.role)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBg)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
