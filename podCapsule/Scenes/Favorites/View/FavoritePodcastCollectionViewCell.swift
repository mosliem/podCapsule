//
//  CollectionViewCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/10/22.
//

import UIKit
import SDWebImage

class FavoritePodcastCollectionViewCell: UICollectionViewCell {

    static let identifier = "FavoritePodcastCollectionViewCell"
    
    @IBOutlet weak var imageShadowView: UIImageView!
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var podcastTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRounded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        podcastImageView.image = nil
        podcastTitleLabel.text = nil
    }
    
    func imageRounded(){
        podcastImageView.layer.cornerRadius = 20
        imageShadowView.layer.cornerRadius = 20
        imageShadowView.layer.shadowRadius = 4
        imageShadowView.layer.shadowColor = #colorLiteral(red: 0.0383454673, green: 0.1741192639, blue: 0.2161790133, alpha: 1).cgColor
        imageShadowView.layer.shadowOpacity = 0.3
        imageShadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
}


extension FavoritePodcastCollectionViewCell: FavoritePodcastCellView{
    
    func displayPodcastImage(imageURL: URL?){
        podcastImageView.sd_setImage(with: imageURL)
    }
    
    func displayPodcastTitle(title: String){
        podcastTitleLabel.text = title
    }
}
