//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 20/01/23.
//

import Combine
import Foundation

public final class GamesViewModel: ObservableObject, GameRepository {
    
    @Published var teamsPlaying: [TeamDTO] = []
    @Published var matechesHeld: [MatchesDTO] = []
    
    public var teamsPublisher: AnyPublisher<TeamDTO, any Error>?
    public var matchesPublisher: AnyPublisher<MatchesDTO, any Error>?
    
    
    public init() { // Fetch from coredata here...
        teamsPublisher = try? NetworkLayer.standard.getInformationFromDatabase(for: .teams, and: TeamDTO.self) as! AnyPublisher<TeamDTO, any Error>
        matchesPublisher = try?  NetworkLayer.standard.getInformationFromDatabase(for: .matches, and: MatchesDTO.self) as! AnyPublisher<MatchesDTO, any Error>
    }

    public func validateTeamsInformation() {
        guard teamsPublisher != nil else {return}
//        teamsPublisher
//            .assign(to: teamsPlaying, on: )
    }
    
    public func validateMatchesInformation() {
        guard matchesPublisher != nil else {return}
    }
    
}


