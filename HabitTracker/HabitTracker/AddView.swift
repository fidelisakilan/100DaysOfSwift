//
//  AddView.swift
//  HabitTracker
//
//  Created by Fidelis Akilan on 8/31/25.
//

import SwiftUI

struct AddView: View {
    let habitList: HabitList
    let habit: HabitItem?
    @Environment(\.dismiss) var dismiss
    @State private var title: String
    @State private var description: String
    @State private var activityCount: Int

    init(habitList: HabitList, habit: HabitItem? = nil) {
        self.habitList = habitList
        self.habit = habit
        _title = State(initialValue: habit?.title ?? "")
        _description = State(initialValue: habit?.description ?? "")
        _activityCount = State(initialValue: habit?.activityCount ?? 0)

    }
    var body: some View {
        NavigationStack {
            Form {
                Section(habit != nil ? "Title & Description" : "") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                if habit != nil {
                    Section("Activity Count") {
                        TextField("", value:$activityCount, formatter: NumberFormatter())
                    }
                }
            }
            .navigationTitle("Add Habit")
                .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Confirm") {
                        if let habit = habit {
                            let index = habitList.items.firstIndex(of: habit)
                            habitList.items[index!] = HabitItem(title: title, description: description, activityCount: activityCount)
                        } else {
                            habitList.items.append(HabitItem(title: title, description: description))
                        }
                        dismiss()
                    }
                    .disabled(title == "" || description == "")
                }
            }
        }
    }
}

#Preview {
    AddView(habitList: HabitList())
}
