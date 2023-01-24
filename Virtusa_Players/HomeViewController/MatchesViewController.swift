//
//  MatchesViewController.swift
//  Virtusa_Players
//
//  Created by Sraavan Chevireddy on 23/01/23.
//

import UIKit

class MatchesViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var homeViewModel: HomeViewModel!
    
    convenience init(model: HomeViewModel!) {
        self.init()
        self.homeViewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Matches"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        configureDataStore()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: matchesGridSection())
        view.addSubview(collectionView)
    }
    
    func matchesGridSection() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         let groupSize = NSCollectionLayoutSize(widthDimension:        .fractionalWidth(0.7), heightDimension: .absolute(80))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .continuous
         return section
    }
    
    private func configureDataStore() {
        
    }
    
}
