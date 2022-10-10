//
//  FavoriteEpisodeCollectionViewCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/10/22.
//

import UIKit
import SDWebImage

class FavoriteEpisodeCollectionViewCell: UICollectionViewCell {

    static let identifier = "FavoriteEpisodeCollectionViewCell"
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var publisherTitleLabel: UILabel!
    @IBOutlet weak var episodeDuarionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundEpisodeImage()
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
        
        episodeImageView.image = nil
        episodeTitleLabel.text = nil
        episodeDuarionLabel.text = nil
        publisherTitleLabel.text = nil
    }
    
    private func roundEpisodeImage(){
        episodeImageView.layer.cornerRadius = 20
    }
}

extension FavoriteEpisodeCollectionViewCell{
    
    func displayEpisodeImage(with imageURL: URL?){
        episodeImageView.sd_setImage(with: imageURL)
    }
    
    func displayEpisodePublisher(publisher: String){
        publisherTitleLabel.text = publisher
    }
    
    func displayEpisodeTitle(title: String){
        episodeTitleLabel.text = title
    }
    
    func displayDuraion(duration: String){
        episodeDuarionLabel.text = duration
    }
    
}
