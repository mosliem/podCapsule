//
//  TableViewCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/5/22.
//

import UIKit

class PodcastDetailsEpisodesTableViewCell: UITableViewCell {

    static let identifier = "PodcastDetailsEpisodesTableViewCell"
    
    @IBOutlet weak var imageShadowView: UIView!
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundEpisodeImageView()
        imageShadow()
    }
    
    func roundEpisodeImageView(){
        episodeImageView.clipsToBounds = true
        episodeImageView.layer.cornerRadius = 15
        
        imageShadowView.layer.cornerRadius = 15
    }
    
    func imageShadow(){
        imageShadowView.layer.shadowColor = UIColor.lightGray.cgColor
        imageShadowView.layer.shadowRadius = 5
        imageShadowView.layer.shadowOpacity = 0.4
        imageShadowView.layer.shadowOffset = CGSize(width: 0, height: 2.5)
    }
    
}
