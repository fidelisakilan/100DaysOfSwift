//
//  File.swift
//  ImageViewer
//
//  Created by Fidelis Akilan on 4/5/26.
//

import Foundation
import UIKit
import CoreLocation


struct Post: Codable, Identifiable, Equatable, Comparable, Hashable {
    var id: UUID
    var name: String
    var imageData: Data
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var image : UIImage? {
        UIImage(data: imageData)
    }
    
    static func <(lhs: Post, rhs: Post) -> Bool {
        lhs.name < rhs.name
    }
    
    
    #if DEBUG
    static let example = CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)
    #endif
    
    //    static func ==(lhs: Post, rhs: Post) -> Bool {
    //        lhs.id == rhs.id
    //    }
    
    //    init(id: UUID, name: String, image: Data) {
    //        self.id = id
    //        self.name = name
    //        self.image = image
    //    }
}
