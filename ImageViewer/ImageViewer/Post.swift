//
//  File.swift
//  ImageViewer
//
//  Created by Fidelis Akilan on 4/5/26.
//

import Foundation
import UIKit


struct Post: Codable, Identifiable, Equatable, Comparable, Hashable {
    var id: UUID
    var name: String
    var imageData: Data
    
    var image : UIImage? {
        UIImage(data: imageData)
    }
    
    static func <(lhs: Post, rhs: Post) -> Bool {
        lhs.name < rhs.name
    }

    //    static func ==(lhs: Post, rhs: Post) -> Bool {
    //        lhs.id == rhs.id
    //    }

//    init(id: UUID, name: String, image: Data) {
//        self.id = id
//        self.name = name
//        self.image = image
//    }
}
