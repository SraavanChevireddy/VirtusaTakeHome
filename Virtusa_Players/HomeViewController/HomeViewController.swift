//
//  HomeViewController.swift
//  Virtusa_Players
//
//  Created by Sraavan Chevireddy on 18/01/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
        
    private var homeViewModel: HomeViewModel!
    private var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private var collectionView : UICollectionView!
    
    enum Section {
        case main
    }
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Video>

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeViewModel = HomeViewModel()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .red
//        makeDataSource()
        homeViewModel.subscribeGames()
    }
    
    func makeDataSource() -> DataSource {
      // 1
      let dataSource = DataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, video) ->
          UICollectionViewCell? in
          // 2
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PlayersCollectionViewCell",
            for: indexPath) as? PlayersCollectionViewCell
            cell?.backgroundColor = UIColor.green
          return cell
      })
      return dataSource
    }


}


class Video : Hashable {
    var id: String!
    
    static func == (lhs: Video, rhs: Video) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}
