//
//  HomeViewModel.swift
//  Virtusa_Players
//
//  Created by Sraavan Chevireddy on 22/01/23.
//

import Combine
import Foundation
import PlayersKit
import UIKit

class HomeViewModel: ObservableObject, GameRepository {

    var cancellables = Set<AnyCancellable>()
    var gameRoom: GamesViewModel!
    
    @Published var teams: TeamDTO!

    init() {
        gameRoom = GamesViewModel()
    }
    
    func subscribeGames() {
        validateTeamsInformation()
        validateMatchesInformation()
    }
    
    func validateTeamsInformation() {
        if let teams = gameRoom.teamsPublisher {
            teams.receive(on: RunLoop.main)
                .sink { result in
                    debugPrint("You got some result \(result)")
                } receiveValue: { [weak self] teams in
                    self?.teams = teams
                    print("You got teams! \(teams)")
                }.store(in: &cancellables)
        } else {
            debugPrint("GONE!")
        }
    }
    
    func validateMatchesInformation() {
        if let teams = gameRoom.matchesPublisher {
            teams.receive(on: RunLoop.main)
                .sink { result in
                    debugPrint("You got some result \(result)")
                } receiveValue: { matches in
                    print("You got matches!")
                }.store(in: &cancellables)
        }
    }
    
    func team(withId: String) -> Team?{
        return teams.teams.first(where: { $0.id == withId })
    }
    
    func  teamIds() -> [Team.ID] {
        return teams.teams.map { $0.id }
    }
    
    
}
