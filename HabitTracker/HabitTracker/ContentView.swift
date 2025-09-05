//
//  ContentView.swift
//  HabitTracker
//
//  Created by Fidelis Akilan on 8/23/25.
//

import SwiftUI

struct HabitTileView : View {
    let habit: HabitItem
    let habitList: HabitList
    
    func onIncrement() {
        let index = habitList.items.firstIndex(of: habit)
        habitList.items[index!] = HabitItem(title: habit.title, description: habit.description, activityCount: habit.activityCount + 1)
    }
    var body: some View {
        HStack {
            NavigationLink {
                AddView(habitList: habitList, habit: habit)
            } label: {
                VStack(alignment: .leading) {
                    Text(habit.title).font(.body)
                    if habit.description != "" { Text(habit.description).font(.footnote) }
                }
                .padding(.horizontal)
            }
            .navigationLinkIndicatorVisibility(.hidden)
            Spacer()
            Group {
                Text(String(habit.activityCount))
                Button(action: onIncrement) {
                    Image(systemName: "plus")
                }
            }
            .frame(height: 25)
            .padding(.horizontal, 10)
            .font(.caption)
            .fontWeight(.bold)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            .buttonStyle(.plain)
        }
    }
}

struct ContentView: View {
    @State private var userHabits = HabitList()
    @State private var showingAddSheet = false
    var body: some View {
        NavigationStack {
            Section {
                List {
                    ForEach(userHabits.items) { item in
                        HabitTileView(habit: item, habitList: userHabits)
                    }
                    .onDelete(perform: onDelete)
                }
            }
            .navigationTitle("Your Habits")
            .toolbar {
                if !userHabits.items.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Habit") {
                        showingAddSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddView(habitList: userHabits)
            }
        }
    }
    
    func onDelete(at offsets: IndexSet) {
        userHabits.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
