//
//  Missions.swift
//  Moonshot
//
//  Created by Fidelis Akilan on 6/25/25.
//

import Foundation


struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let description: String
    let launchDate: Date?
    let crew: [CrewRole]
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var logoName: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date:.abbreviated,time: .omitted) ?? "N/A"
    }
}
