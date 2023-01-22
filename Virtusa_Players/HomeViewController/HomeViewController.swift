//
//  HomeViewController.swift
//  Virtusa_Players
//
//  Created by Sraavan Chevireddy on 18/01/23.
//

import UIKit
import Combine
import PlayersKit

class HomeViewController: UIViewController {
        
    private var homeViewModel: HomeViewModel!
    private var collectionView: UICollectionView!
    
    /// - Tag: Games grid
    enum GamesGrid: Int {
        case main
    }
    /// - Tag: gamesDataSource
    var gamesDataSource: UICollectionViewDiffableDataSource<GamesGrid, Team.ID>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        configureCollectionViewLayout()
        homeViewModel = HomeViewModel()
        homeViewModel.subscribeGames()
        configureDataSource()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.loadGamesInformation()
        }
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            
            return section
        }
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
    }
    
    private func trailingSwipeActionsConfiguration(for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    private func configureDataSource() {
        let teamsCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Team> { cell, indexPath, team in
            var contentConfiguration = UIListContentConfiguration.subtitleCell()
            contentConfiguration.text = team.name
            contentConfiguration.secondaryText = "Team"
//            contentConfiguration.image = recipe.smallImage
//            contentConfiguration.imageProperties.cornerRadius = 4
//            contentConfiguration.imageProperties.maximumSize = CGSize(width: 60, height: 60)
            cell.contentConfiguration = contentConfiguration
            cell.accessories = []
        }
        
        // Create the diffable data source and its cell provider.
        gamesDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, identifier -> UICollectionViewCell in
            /// `identifier` is an instance of `Team.ID`. Use it to
            // retrieve the recipe from the backing data store.
            let team = self.homeViewModel.team(withId: identifier)!
            return collectionView.dequeueConfiguredReusableCell(using: teamsCellRegistration, for: indexPath, item: team)
        }
    }
    
    private func loadGamesInformation() {
        // Update the collection view by adding the recipe identifiers to
        // a new snapshot, and apply the snapshot to the diffable data source.
        var snapshot = NSDiffableDataSourceSnapshot<GamesGrid, Team.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(homeViewModel.teamIds(), toSection: .main)
        gamesDataSource.applySnapshotUsingReloadData(snapshot)
    }
}

