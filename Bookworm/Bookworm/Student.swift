//
//  Student.swift
//  Bookworm
//
//  Created by Fidelis Akilan on 9/21/25.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
