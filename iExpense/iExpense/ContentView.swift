import SwiftUI
import SwiftData

struct ContentView : View {
    @State private var sortOrder: [SortDescriptor] = [SortDescriptor(\ExpenseItem.name), SortDescriptor(\ExpenseItem.amount)]
    @State private var filterGroup: String = "All"
    var body: some View {
        NavigationStack {
            List {
                ExpenseView(filter: filterGroup, sortOrder: sortOrder)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name").tag([
                            SortDescriptor(\ExpenseItem.name),
                            SortDescriptor(\ExpenseItem.amount)
                        ])
                        Text("Sort by Amount").tag([
                            SortDescriptor(\ExpenseItem.amount),
                            SortDescriptor(\ExpenseItem.name)
                        ])
                    }
                }
                Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                    Picker("Filter", selection: $filterGroup) {
                        Text("All").tag("All")
                        Text("Business").tag("Business")
                        Text("Personal").tag("Personal")
                    }
                }
                NavigationLink("Add Expense") {
                    AddView()
                }
            }
        }
    }
}


struct ExpenseView: View {
    @Query var expenses: [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        if !expenses.isEmpty {
            ForEach(expenses) { item in
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
            .onDelete { offsets in
                onDelete(at: offsets)
            }
        }
    }
    func onDelete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
    }
    
    init(filter: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        if filter == "All" {
            _expenses = Query(sort: sortOrder)
        } else {
            _expenses = Query(filter: #Predicate<ExpenseItem>{item in
                item.type == filter
            }, sort: sortOrder)
        }
    }
}


#Preview {
    ContentView()
}
