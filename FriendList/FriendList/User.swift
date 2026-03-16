//
//  User.swift
//  FriendList
//
//  Created by Fidelis Akilan on 3/16/26.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable, Identifiable, Hashable {
    var id: String
    var name: String
}
