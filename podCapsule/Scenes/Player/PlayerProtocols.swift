//
//  PlayerProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/27/22.
//

import UIKit

protocol PlayerView: class {
    
    var presenter: PlayerViewPresenter? { get set }
    
    func setMaxSliderVal(value: Float)
   
    func displayEpisodeImage(url: URL?)
    
    func displayPodcastTitle(title: String)
    func displayPublisherName(publisher: String)
    func displayEpisodeTitle(title: String)
    
    func displayDuration(duration: String)
    func updatePlaybackTime(time: String)
    
    func updateSliderValue(value: Float)
    
    func updatePlayPauseImage(with ImageName: String)
    func updateLoveButton(with image: String)
    
    
}

extension PlayerView {
    func viewErrorAlert(title: String, message: String, actionTitle: String, actionHandler: ((UIAlertAction) -> Void)? = nil){}
}


protocol PlayerViewPresenter: class {
    
    var view: PlayerView? { get set }
    var router: PlayerViewRouter? { get set }
    var episode: EpisodeObject? { get set }
 
    init(view: PlayerView?, interactor: PlayerInteractorInput?, router: PlayerViewRouter?, episode: EpisodeObject?, audioPlayer: AudioPlayerSessionProtocol?)
    
    func viewDidLoad()
    func playPausePressed()
    func backwardPressed(currentTime: Float)
    func forwardPressed(currentTime: Float)
    func bookmarkPressed()
    func backPressed()
    func sliderValueChanged(value: Float)

}


protocol PlayerViewRouter: class {
    
    func dismissPlayerVC()
}

protocol PlayerInteractorInput: class {
    
    var presenter: PlayerInteractorOutput? { get set }
    
    func addNew(recentlyPlayed episode: RecentlyPlayedEpisodeModel)
    
    func addToLovedList(lovedEpisode: LovedEpisode)
    
    func removeFromLovedList(id: String, type: LovedEpisode.Type)
    
    func isExistInLovedList(id: String)

}

protocol PlayerInteractorOutput: class {
    
    var interactor: PlayerInteractorInput? { get set }
    
    func existedInLovedList(existed: Bool)
    func failed(with error: String)
    
}

protocol AudioPlayerUpdaterProtocol: class {
 
    var audioPlayer: AudioPlayerSessionProtocol? { get set }
    
    func error(with errorMessage: String)
    
    func updatesCurrentPlaybackTime(value: Double?)
    
    func didFinishPlaying()

}

protocol AudioPlayerSessionProtocol: class  {
    var presenter: AudioPlayerUpdaterProtocol? { get set }
    
    func setAudioURL(url: URL)
    func setupPlayer()
    func startPlaying()
    func pausePlaying()
    func seekToVal(value: Double)

}
