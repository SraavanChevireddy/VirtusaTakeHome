//
//  MatchesViewController.swift
//  Virtusa_Players
//
//  Created by Sraavan Chevireddy on 23/01/23.
//

import UIKit

class MatchesViewController: UIViewController {

    private var homeViewModel: HomeViewModel!
    
    convenience init(model: HomeViewModel!) {
        self.init()
        self.homeViewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Matches"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
}
