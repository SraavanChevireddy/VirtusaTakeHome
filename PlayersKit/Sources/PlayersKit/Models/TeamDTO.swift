//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 20/01/23.
//

import Foundation

public struct TeamDTO: Codable {
    let teams: [Team]
}

// MARK: - Team
public struct Team: Codable {
    let id, name: String
    let logo: String
}
