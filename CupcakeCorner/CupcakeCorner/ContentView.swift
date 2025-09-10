import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var email = ""
    private var disableForm: Bool {
        name.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create User") {
                    print("Creating User...")
                }
                .disabled(disableForm)
            }
        }
    }
}

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
