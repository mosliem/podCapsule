//
//  PlayerVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/27/22.
//

import UIKit
import SDWebImage


extension PlayerVC: PlayerView{
    
    func setMaxSliderVal(value: Float) {
        playerSlider.maximumValue = value
    }
    

    func displayDuration(duration: String) {
        durationLabel.text = duration
    }
    
    func updatePlaybackTime(time: String) {
        playbackTimeLabel.text = time
    }
    
    func updateSliderValue(value: Float) {
        playerSlider.value = value
    }
    
    
    func displayEpisodeImage(url: URL?) {
        episodePosterImageView.sd_setImage(with: url)
    }
    
    func displayPodcastTitle(title: String) {
        podcastTitleLabel.text = title
    }
    
    func displayPublisherName(publisher: String) {
        publisherNameLabel.text = publisher
    }
    
    func displayEpisodeTitle(title: String) {
        episodeTitleLabel.text = title
    }
    
    func updatePlayPauseImage(with ImageName: String) {
        playPauseButton.setImage(UIImage(systemName: ImageName), for: .normal)
    }
    

    
    func viewErrorAlert(title: String, message: String, actionTitle: String, actionHandler: ((UIAlertAction) -> Void)? = nil)  {
        self.showAlertWithOk(alertTitle: title, message: message, actionTitle: actionTitle, actionHandler: actionHandler)
    }
    
    func updateLoveButton(with image: String) {
        loveButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
    
}
