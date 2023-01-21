//
//  PlayersCollectionViewCell.swift
//  Virtusa_Players
//
//  Created by Sraavan Chevireddy on 18/01/23.
//

import UIKit

class PlayersCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUIComponents(){
        contentView.backgroundColor = UIColor.red
    }
}
