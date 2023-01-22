//
//  GameViewController.swift
//  Virtusa_Players
//
//  Created by Sraavan Chevireddy on 23/01/23.
//

import UIKit

class GameViewController: UITabBarController {

    private var teamsViewController: HomeViewController!
    private var matchesViewController: MatchesViewController!
    
    private var homeModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        homeModel = HomeViewModel()
        homeModel.subscribeGames()
        
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        let teamsTabBarItem = UITabBarItem(title: "Teams", image: UIImage(systemName: "heart.fill"), tag: 0)
        let matchesTabBarItem = UITabBarItem(title: "Matches", image: UIImage(systemName: "gamecontroller.fill"), tag: 1)
        
        teamsViewController = HomeViewController(model: homeModel)
        teamsViewController.tabBarItem = teamsTabBarItem
        
        matchesViewController = MatchesViewController(model: homeModel)
        matchesViewController.tabBarItem = matchesTabBarItem
        
        let tabBarList = [
           teamsViewController, matchesViewController
        ]
        viewControllers = tabBarList.map{ UINavigationController.init(rootViewController: $0! )}
    }
    
}
