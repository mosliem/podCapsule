//
//  PodcastCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/2/22.
//

import UIKit
import SDWebImage

class PodcastCell: UICollectionViewCell {

    static let identifier = "PodcastCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageShadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRounded()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
    }

    override func prepareForReuse(){
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
    }
    
    
    func imageRounded(){
        posterImageView.layer.cornerRadius = 20
        posterImageShadowView.layer.cornerRadius = 20
        posterImageShadowView.layer.shadowRadius = 4
        posterImageShadowView.layer.shadowColor = #colorLiteral(red: 0.0383454673, green: 0.1741192639, blue: 0.2161790133, alpha: 1).cgColor
        posterImageShadowView.layer.shadowOpacity = 0.3
        posterImageShadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    
}

extension PodcastCell: PodcastCellView{
    
    func displayPosterImage(urlString: String) {
       
        DispatchQueue.main.async {
            self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)

        }
    }
    
    func displayName(for podcast: String) {
        titleLabel.text = podcast
    }
    
}
