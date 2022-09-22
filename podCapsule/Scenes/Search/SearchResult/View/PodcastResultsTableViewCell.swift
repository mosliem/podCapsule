//
//  PodcastResultsTableViewCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/17/22.
//

import UIKit
import SDWebImage

class PodcastResultsTableViewCell: UITableViewCell {
    
    static let identifier = "PodcastResultsTableViewCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var genreLabel: GenreLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRounded()
        genreLabelInsets()
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        publisherLabel.text = nil
        genreLabel.text = nil
        genreLabel.isHidden = true
        
    }
    
    private func genreLabelInsets(){
        let edgeInset = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        genreLabel.setEdgeInsets(insets: edgeInset)
        genreLabel.layer.cornerRadius = 5
        genreLabel.clipsToBounds = true
    }

    private func imageRounded(){
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10
    }
    
}


extension PodcastResultsTableViewCell: PodcastResultsTableCellView{
 
    func displayTitle(title: String) {
        titleLabel.text = title
    }
    
    func displayPublisher(publisher: String) {
        publisherLabel.text = publisher
    }
    
    func displayGenre(genre: String) {
        genreLabel.isHidden = false
        genreLabel.text = genre
    }
    
    func displayImage(with url: URL) {
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
    func displayDefaultImage() {
        posterImageView.image = UIImage(named: "podcast")
    }
    
    
}

