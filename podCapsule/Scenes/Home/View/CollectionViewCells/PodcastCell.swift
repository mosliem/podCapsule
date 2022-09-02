//
//  PodcastCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/2/22.
//

import UIKit

class PodcastCell: UICollectionViewCell {

    static let identifier = "PodcastCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRounded()
 
    }

    override func prepareForReuse(){
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
    }
    
    func imageRounded(){
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 25
    }
}

extension PodcastCell: PodcastCellView{
    
    func displayPosterImage(urlString: String?) {
        
    }
    
    func displayName(for episode: String) {
        
    }
    
}
