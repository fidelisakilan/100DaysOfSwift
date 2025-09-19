//
//  Order.swift
//  CupcakeCorner
//
//  Created by Fidelis Akilan on 9/12/25.
//

import Foundation

@Observable
class Order : Codable {
    
    init() {
        streetAddress = UserDefaults.standard.string(forKey: "order_address") ?? ""
        city = UserDefaults.standard.string(forKey: "order_city") ?? ""
        zip = UserDefaults.standard.string(forKey: "order_zip") ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extrafrosting = "extrafrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    
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
    
    var name = ""
    var streetAddress: String {
        didSet {
            if streetAddress.trimmingCharacters(in: .whitespaces).isEmpty {
                UserDefaults.standard.removeObject(forKey: "order_address")
            } else {
                UserDefaults.standard.set(streetAddress, forKey: "order_address")
            }
        }
    }
    
    var city: String {
        didSet {
            if city.trimmingCharacters(in: .whitespaces).isEmpty {
                UserDefaults.standard.removeObject(forKey: "order_city")
            } else {
                UserDefaults.standard.set(city, forKey: "order_city")
            }
        }
    }
    
    var zip: String {
        didSet {
            if zip.trimmingCharacters(in: .whitespaces).isEmpty {
                UserDefaults.standard.removeObject(forKey: "order_zip")
            } else {
                UserDefaults.standard.set(zip, forKey: "order_zip")
            }
        }
    }
    
    
    var hasInvalidAddress: Bool {
        return name.trimmingCharacters(in: .whitespaces).isEmpty ||
        streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
        city.trimmingCharacters(in: .whitespaces).isEmpty ||
        zip.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var cost: Decimal {
        
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extrafrosting {
            cost += Decimal(quantity)
        }
        
        // $0.5/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
