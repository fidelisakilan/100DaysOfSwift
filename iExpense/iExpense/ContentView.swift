//
//  ContentView.swift
//  iExpense
//
//  Created by Fidelis Akilan on 6/21/25.
//
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    var currency: String
}

@Observable
class Expenses {
    var key: String
    
    init(key: String) {
        self.key = key
        if let encodedItems = UserDefaults.standard.data(forKey: self.key) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: encodedItems) {
                items = decodedItems
                return
            }
            items = []
        }
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}

struct ExpenseTileView: View {
    var item: ExpenseItem
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name).font(.headline)
                Text(item.type).font(.caption)
            }
            Spacer()
            if item.amount <= 10 {
                Text(item.amount,format: .currency(code: item.currency))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            } else if item.amount <= 100 {
                Text(item.amount,format: .currency(code: item.currency))
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
            } else{
                Text(item.amount,format: .currency(code: item.currency))
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
        }
    }
}

struct ContentView : View {
    @State var personalExpenses = Expenses(key: "personalItems")
    @State var businessExpenses = Expenses(key: "businessItems")
    
    @State var showingAddExpense = false
    var body: some View {
        NavigationStack {
            List {
                if !personalExpenses.items.isEmpty {
                    Section("Personal") {
                        ForEach(personalExpenses.items) { item in
                            ExpenseTileView(item: item)
                        }
                        .onDelete { offsets in
                            onDelete(at: offsets, expenses: personalExpenses)
                        }
                    }
                }
                if !businessExpenses.items.isEmpty {
                    Section("Work") {
                        ForEach(businessExpenses.items) { item in
                            ExpenseTileView(item: item)
                        }
                        .onDelete { offsets in
                            onDelete(at: offsets, expenses: businessExpenses)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense",systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
            }
        }
    }
    func onDelete(at offsets: IndexSet, expenses: Expenses) {
        expenses.items.remove(atOffsets: offsets)
    }
}

//struct User: Codable {
//    var firstName: String
//    var lastName: String
//}
//
//struct ContentView: View {
//    @State private var user = User(firstName: "Maruti", lastName: "Swift")
//    var body: some View {
//        Button("Tap me to save") {
//            let encoder = JSONEncoder()
//            if let data = try? encoder.encode(user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
//    }
//}




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
