//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 20/01/23.
//

import Foundation

public struct MatchesDTO: Codable {
    let matches: Matches
}

public struct Matches: Codable {
    let previous: [Previous]
    let upcoming: [Upcoming]
}

public struct Previous: Codable {
    let date, description, home, away: String
    let winner: String
    let highlights: String
}

public struct Upcoming: Codable {
    let date, description, home, away: String
}
