//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Fidelis Akilan on 6/21/25.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
