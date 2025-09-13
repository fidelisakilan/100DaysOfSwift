//
//  Order.swift
//  CupcakeCorner
//
//  Created by Fidelis Akilan on 9/12/25.
//

import Foundation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extrafrosting = false
                addSprinkles = false
            }
        }
    }
    var extrafrosting = false
    var addSprinkles = false
}
