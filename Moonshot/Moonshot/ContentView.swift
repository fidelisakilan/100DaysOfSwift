//
//  ContentView.swift
//  Moonshot
//
//  Created by Fidelis Akilan on 6/24/25.
//

import SwiftUI

struct ContentView: View {
    let rows = [
        GridItem(.adaptive(minimum: 60, maximum: 120))
    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(0..<1000) {
                    Text("\($0)")
                }
            }
        }
    }
}


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
