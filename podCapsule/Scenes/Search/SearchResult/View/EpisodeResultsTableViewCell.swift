//
//  SearchResultsTableViewCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/11/22.
//

import UIKit
import SDWebImage

class EpisodeResultsTableViewCell: UITableViewCell {
    
    static let  identifier = "EpisodeResultsTableViewCell"
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imageRounded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        publisherLabel.text = nil
        durationLabel.text = nil
        
    }
    
    private func imageRounded(){
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10
    }
    
    
}


extension EpisodeResultsTableViewCell: EpisodeResultsTableCellView {
    

    
    func displayTitle(title: String) {
        titleLabel.text = title
    }
    
    func displayPublisher(publisher: String) {
        publisherLabel.text = publisher
    }
    
    func displayDuration(duration: String) {
        durationLabel.text = duration
    }
    
    func displayImage(with url: URL) {
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
    func displayDefaultImage() {
        posterImageView.image = UIImage(named: "EP")
    }
    
}
