//
//  Location.swift
//  BucketList
//
//  Created by Fidelis Akilan on 3/27/26.
//

import Foundation
import MapKit

struct CLocation: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example: CLocation = CLocation(id: UUID(), name: "Bucklingham Palace", description: "Lit by over 40,000 bulbs", latitude: 51.501, longitude: -0.141)
    #endif
    
    static func ==(lhs: CLocation, rhs: CLocation) -> Bool {
        lhs.id == rhs.id
    }
}
