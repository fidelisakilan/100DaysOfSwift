//
//  AddView.swift
//  iExpense
//
//  Created by Fidelis Akilan on 6/22/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    let types = ["Personal", "Business"]
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type",selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                TextField("Currency", text: $currency)
                TextField("Amount", value: $amount, format: .currency(code: currency))
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if name == "" || name == "Enter Name" {
                            return
                        }
                        let expense = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                        modelContext.insert(expense)
                        dismiss()
                    }
                    .disabled(name.isEmpty || name == "Enter Name")
                }
            }
        }
    }
}

#Preview {
    AddView()
}
