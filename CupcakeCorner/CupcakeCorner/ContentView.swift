import SwiftUI
import CoreHaptics


struct ContentView: View {
    @State var engine: CHHapticEngine?
    var body: some View {
        Button("Tap Me", action: performHaptics)
            .onAppear(perform: prepareHaptics)
    }
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error starting HapticEngine \(error.localizedDescription)")
        }
    }
    func performHaptics() {
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}


//@Observable
//class User: Codable {
//    enum CodingKeys: String, CodingKey  {
//        case _name = "name"
//    }
//    
//    var name = "Taylor"
//}
//
//struct ContentView: View {
//    @State private var name = ""
//    @State private var email = ""
//    private var disableForm: Bool {
//        name.count < 5 || email.count < 5
//    }
//    var body: some View {
//        Form {
//            Section {
//                TextField("Name", text: $name)
//                TextField("Email", text: $email)
//            }
//            Section {
//                Button("Create User") {
//                    print("Creating User...")
//                }
//                .disabled(disableForm)
//            }
//            Button("Encode User", action: encodeUser)
//        }
//    }
//    func encodeUser() {
//        let encoded = try! JSONEncoder().encode(User())
//        let str = String(decoding: encoded, as: UTF8.self)
//        print(str)
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else if phase.error != nil {
//                Text("Error Occurred")
//            } else {
//                ProgressView()
//            }
//        }
//        .frame(width: 200, height: 200)
//    }
//}

//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//
//struct ContentView: View {
//    @State private var results = [Result]()
//    var body: some View {
//        List(results, id: \.trackId) { result in
//            VStack(alignment: .leading) {
//                Text(result.trackName).font(.caption).bold()
//                Text(result.collectionName).font(.caption2)
//            }
//        }
//        .task {
//            await loadData()
//        }
//    }
//    
//    func loadData() async {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
//            results = decodedResponse.results
//        } catch {
//            print("Invalid data \(error)")
//        }
//    }
//}

#Preview {
    ContentView()
}
