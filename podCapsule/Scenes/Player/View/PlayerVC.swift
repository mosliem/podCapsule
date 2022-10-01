//
//  PlayerVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

class PlayerVC: UIViewController {
    
    var presenter: PlayerViewPresenter?
    
    @IBOutlet weak var podcastTitleLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var playerSlider: UISlider!
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var episodePosterImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playbackTimeLabel: UILabel!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureEpisodeImageView()
        configureSlider()
        
        presenter?.viewDidLoad()
    }
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        presenter?.playPausePressed()
    }
    
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
        presenter?.backwardPressed(currentTime: playerSlider.value)
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        presenter?.forwardPressed(currentTime: playerSlider.value)
    }
    
    @IBAction func loveButtonPressed(_ sender: UIButton) {
        presenter?.bookmarkPressed()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        presenter?.backPressed()
    }
    
    @IBAction func didChangeSliderValue(_ sender: UISlider) {
        presenter?.sliderValueChanged(value: sender.value)
    }
    
    
    
    //MARK:- Private functions
    private func configureSlider(){
        
        var normalImage = UIImage(named: "sliderThumb")?.withRenderingMode(.alwaysTemplate).withTintColor(#colorLiteral(red: 0.3050049543, green: 0.2740188837, blue: 0.4402385354, alpha: 1))
        normalImage = UIImage.resizeImage(image: normalImage!, 22, opaque: false)
        playerSlider.setThumbImage(normalImage, for: .normal)
        
        var highlightedImage = UIImage(named: "sliderThumb")?.withRenderingMode(.alwaysTemplate).withTintColor(#colorLiteral(red: 0.3050049543, green: 0.2740188837, blue: 0.4402385354, alpha: 1))
        highlightedImage = UIImage.resizeImage(image: highlightedImage!, 27, opaque: false)
        playerSlider.setThumbImage(highlightedImage, for: .highlighted)
        
    }
    
    private func configureEpisodeImageView(){
        
        episodePosterImageView.clipsToBounds = true
        episodePosterImageView.layer.cornerRadius = 20
    }
}
