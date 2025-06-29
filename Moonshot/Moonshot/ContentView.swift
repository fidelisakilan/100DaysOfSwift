//
//  ContentView.swift
//  Moonshot
//
//  Created by Fidelis Akilan on 6/24/25.
//

import SwiftUI


struct MissionListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    var body: some View {
        ForEach(missions) { mission in
            NavigationLink{
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack {
                    Image(mission.logoName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    VStack {
                        Text(mission.displayName)
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.lightBg)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBg)
                }
            }
        }
    }
}

struct MissionGridView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    var body: some View {
        ForEach(missions) { mission in
            NavigationLink{
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                VStack {
                    Image(mission.logoName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    VStack {
                        Text(mission.displayName)
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBg)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBg)
                }
            }
        }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    @State private var isGridLayout = false
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if isGridLayout {
                        LazyVGrid(columns: columns) {
                            MissionGridView(missions: missions, astronauts: astronauts)
                        }
                    } else {
                        LazyVStack {
                            MissionListView(missions: missions, astronauts: astronauts)
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("MoonShot")
            .background(.darkBg)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Switch Layout", systemImage: isGridLayout ? "list.dash": "circle.grid.2x2") {
                    isGridLayout.toggle()
                }
                .buttonStyle(.plain)
            }
        }
    }
}

//struct ContentView: View {
//    let rows = [
//        GridItem(.adaptive(minimum: 60, maximum: 120))
//    ]
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: rows) {
//                ForEach(0..<1000) {
//                    Text("\($0)")
//                }
//            }
//        }
//    }
//}


//struct User : Codable {
//    let name : String
//    let address: Address
//}
//
//struct Address: Codable {
//    let street: String
//    let city: String
//}
//
//struct ContentView : View {
//    var body: some View {
//        Button("Tap Me") {
//            let input = """
//                {
//                    "name": "Akilan",
//                    "address": {
//                        "street": "Park Avenue St",
//                        "city": "Bay Area"
//                    }
//                }
//                """
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.city)
//            } else {
//                print("ERROR")
//            }
//        }
//
//    }
//}


//struct ContentView : View {
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(0..<100) { row in
//                    NavigationLink("Row \(row)") {
//                        Text("Detail \(row)")
//                    }
//                }
//            }
//            .navigationTitle("SwiftUI")
//        }
//    }
//}

//struct ContentView : View {
//    var body: some View {
//        ScrollView(.vertical) {
//            LazyVStack(spacing: 10) {
//                ForEach(0..<100) {
//                    Text("Text \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        Image(.example)
//            .resizable()
//            .scaledToFit()
//            .containerRelativeFrame(.horizontal) { size, axis in
//                size * 0.8
//            }
//    }
//}

#Preview {
    ContentView()
}
