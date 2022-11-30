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
    
    @IBOutlet weak var imageShadowView: UIView!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var publisherTitleLabel: UILabel!
    @IBOutlet weak var episodeDuarionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRounded()
    }
  
    override func prepareForReuse() {
        super.prepareForReuse()
        
        episodeImageView.image = nil
        episodeTitleLabel.text = nil
        episodeDuarionLabel.text = nil
        publisherTitleLabel.text = nil
    }
    
    func imageRounded(){
        episodeImageView.layer.cornerRadius = 12
        imageShadowView.layer.cornerRadius = 12
        imageShadowView.layer.shadowRadius = 4
        imageShadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageShadowView.layer.shadowColor = #colorLiteral(red: 0.0383454673, green: 0.1741192639, blue: 0.2161790133, alpha: 1).cgColor
        imageShadowView.layer.shadowOpacity = 0.1
    }
}

extension FavoriteEpisodeCollectionViewCell: FavoriteEpisodeCellView{
    
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
