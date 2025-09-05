//
//  Habit.swift
//  HabitTracker
//
//  Created by Fidelis Akilan on 8/23/25.
//

import Foundation
import SwiftUI

struct HabitItem : Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var activityCount: Int = 0
}


@Observable
class HabitList {
    init() {
        if let encodedItems = UserDefaults.standard.data(forKey: "habit-list") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: encodedItems) {
                self.items = decodedItems
                return
            }
        }
        self.items = []
    }
    
    var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "habit-list")
            } else  {
                UserDefaults.standard.removeObject(forKey: "habit-list")
            }
        }
    }
}

