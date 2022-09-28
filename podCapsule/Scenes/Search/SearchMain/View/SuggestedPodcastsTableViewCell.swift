//
//  SuggestedPodcastsTableViewCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit
import SDWebImage

class SuggestedPodcastsTableViewCell: UITableViewCell {
    
    static let identifier = "SuggestedPodcastsTableViewCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundImageView()
    }
    
    func roundImageView(){
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        publisherLabel.text = nil
    }
}

extension SuggestedPodcastsTableViewCell: SuggestedPodcastsCellView {
    
    func displayTitle(podcastTitle: String) {
        titleLabel.text = podcastTitle
    }
    
    func displayPodcastPoster(imageUrl: URL){
        self.posterImageView.sd_setImage(with: imageUrl)
    }
 
    func displayPublisherName(publisher: String){
        self.publisherLabel.text = publisher
    }
    
}
