import Foundation
import SwiftData


@Model
class ExpenseItem: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    var currency: String
    
    init(name: String, type: String, amount: Double, currency: String) {
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }
}
