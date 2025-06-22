//
//  AddView.swift
//  iExpense
//
//  Created by Fidelis Akilan on 6/22/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    var expenses: Expenses
    let types = ["Personal", "Business"]
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type",selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                TextField("Amount", value: $amount,format: .currency(code: "USD"))
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button("Save") {
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expense)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
