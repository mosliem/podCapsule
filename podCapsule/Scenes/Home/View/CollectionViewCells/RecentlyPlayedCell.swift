//
//  RecentlyPlayedCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/2/22.
//

import UIKit

class RecentlyPlayedCell: UICollectionViewCell {

    static let identifier = "RecentlyPlayedCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRounded()
    }

    func imageRounded(){
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 25
    }
}
