//
//  Prospect.swift
//  HotProspects
//
//  Created by Fidelis Akilan on 4/10/26.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddr: String
    var isContacted: Bool
    
    init(name: String, emailAddr: String, isContacted: Bool) {
        self.name = name
        self.emailAddr = emailAddr
        self.isContacted = isContacted
    }
}
