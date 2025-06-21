//
//  ContentView.swift
//  iExpense
//
//  Created by Fidelis Akilan on 6/21/25.
//
import Observation
import SwiftUI


struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Maruti", lastName: "Swift")
    var body: some View {
        Button("Tap me to save") {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}




//struct ContentView: View {
////    @State private var count = UserDefaults.standard.integer(forKey: "Tap")
//    @AppStorage("Tap") private var count = 0
//    var body: some View {
//        Button("You tapped \(count) times") {
//            count += 1
////            UserDefaults.standard.set(count, forKey: "Tap")
//        }
//    }
//}

//struct ContentView: View {
//    @State var listOfNumbers = [Int]()
//    @State var currentNumber = 1
//    var body: some View {
//        NavigationStack {
//            VStack {
//                List {
//                    ForEach(listOfNumbers,id: \.self){
//                        Text("Number \($0)")
//                    }
//                    .onDelete(perform: onDelete)
//                }
//                Button("Add Number") {
//                    listOfNumbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .toolbar{
//                EditButton()
//            }
//        }
//    }
//    
//    func onDelete(at offsets: IndexSet) {
//        listOfNumbers.remove(atOffsets: offsets)
//    }
//}

//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//    let name = "@eva"
//    var body: some View {
//        Button("Dimiss") {
//            dismiss()
//        }
//    }
//}
//
//struct ContentView: View {
//    @State var showingSheet = false
//    var body: some View {
//        Button("Show Sheet"){
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet){
//            SecondView()
//        }
//    }
//}


//@Observable
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Frodo"
//}
//struct ContentView: View {
//    @State private var user = User()
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName)")
//            TextField("First Name", text: $user.firstName)
//            TextField("Last Name", text: $user.lastName)
//        }
//        .padding()
//    }
//}

#Preview {
    ContentView()
}
