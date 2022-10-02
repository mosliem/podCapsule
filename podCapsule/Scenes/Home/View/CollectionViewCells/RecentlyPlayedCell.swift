//
//  RecentlyPlayedCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/2/22.
//

import UIKit
import SDWebImage

class RecentlyPlayedCell: UICollectionViewCell {

    static let identifier = "RecentlyPlayedCell"
    
    @IBOutlet weak var posterShadowView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRounded()
        posterImageShadowView()
    }

    func imageRounded(){
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 20
        
    }
    
    func posterImageShadowView(){
        posterShadowView.layer.cornerRadius = 20
        posterShadowView.layer.shadowColor = UIColor.lightGray.cgColor
        posterShadowView.layer.shadowRadius = 3
        posterShadowView.layer.shadowOpacity = 0.3
        posterShadowView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        remainingTimeLabel.text = nil
    }
}

extension RecentlyPlayedCell: RecentlyPlayedCellView{
    
    func displayPosterImage(url: URL?) {
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
    func displayName(for episode: String) {
        titleLabel.text = episode
    }
    
    func displayRemainingTime(time: String) {
        
    }
   
    func displayDefualtPoster(string: String) {
        posterImageView.image = UIImage(named: string)
    }
    
}
