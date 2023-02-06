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
    
    @Published var teams: [Team]!
    @Published var upcomingMatches: [Upcoming]!
    @Published var previousMatches: [Previous]!
    
    /// - Tag: Teams grid
    enum TeamsGrid: Int {
        case main
    }
    
    /// - Tag: Matches grid
    enum MatchesGrid: Int {
        case previous
        case upcoming
    }
    // A,B,C
    
    /// - Tag: teamDataStore
    var teamDataStore: UICollectionViewDiffableDataSource<TeamsGrid, Team.ID>!
    var previousDataStore: UICollectionViewDiffableDataSource<MatchesGrid, Previous.ID>!
    var upcomingDataStore: UICollectionViewDiffableDataSource<MatchesGrid, Upcoming.ID>!

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
                    self?.teams = teams.teams
                    self?.applyTeamsSnapshot()
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
                } receiveValue: { [weak self] matches in
                    guard let self = self else {
                        return
                    }
                    self.previousMatches = matches.matches.previous
                    self.upcomingMatches = matches.matches.upcoming
                    self.applyMatchesSnapshot()
                }.store(in: &cancellables)
        }
    }
    
    private func applyTeamsSnapshot() {
        // Update the collection view by adding the team identifiers to
        // a new snapshot, and apply the snapshot to the diffable data source.
        var snapshot = NSDiffableDataSourceSnapshot<TeamsGrid, Team.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(teamIds(), toSection: .main)
        teamDataStore.applySnapshotUsingReloadData(snapshot)
    }
    
    private func applyMatchesSnapshot() {
        /// Update the collection view by adding the matches identifiers
        /// ``upcomingDataStore`` and ``previousDataStore`` to
        /// a new snapshot, and apply the snapshot to the diffable data source.
        var snapshot = NSDiffableDataSourceSnapshot<MatchesGrid, Upcoming.ID>()
        snapshot.appendSections([.upcoming])
        snapshot.appendItems(upcomingIds(), toSection: .upcoming)
        upcomingDataStore.applySnapshotUsingReloadData(snapshot)
    }
    
    func team(withId: String) -> Team? {
        return teams.first(where: { $0.id == withId })
    }
    
    func  teamIds() -> [Team.ID] {
        return teams.map { $0.id }
    }
    
    func upcomingIds() -> [Upcoming.ID] {
        return upcomingMatches.map({ $0.id })
    }
    
    func previoudIds() -> [Previous.ID] {
        return previousMatches.map({ $0.id })
    }
}
