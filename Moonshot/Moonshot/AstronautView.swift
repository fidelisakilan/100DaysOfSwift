//
//  AstronautView.swift
//  Moonshot
//
//  Created by Fidelis Akilan on 6/27/25.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding()
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBg)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    AstronautView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
