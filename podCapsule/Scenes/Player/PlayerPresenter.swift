//
//  PlayerPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/27/22.
//

import Foundation

class PlayerPresenter: PlayerViewPresenter {
    
    weak var view: PlayerView?
    
    var router: PlayerViewRouter?
    var interactor: PlayerInteractorInput?
    
    
    var episode: EpisodeObject?
    var audioPlayer: AudioPlayerSessionProtocol?
    private var playedDuration: Double?
    
    var isPlaying: Bool = true
    var isFinished: Bool = false
    var isLoved: Bool = false
    
    weak var playerView: PlayerViewDelegate?
    
    required init(view: PlayerView?, interactor: PlayerInteractorInput?, router: PlayerViewRouter?, episode: EpisodeObject?, audioPlayer: AudioPlayerSessionProtocol?) {
        setInitValues(view: view, interactor: interactor, router: router, episode: episode, audioPlayer: audioPlayer)
    }

    required init(view: PlayerView?, interactor: PlayerInteractorInput?, router: PlayerViewRouter?, episode: EpisodeObject?, audioPlayer: AudioPlayerSessionProtocol?, playedDuration: Double?) {
        setInitValues(view: view, interactor: interactor, router: router, episode: episode, audioPlayer: audioPlayer, playedDuration: playedDuration)
        self.playedDuration = playedDuration
    }
    
    private func setInitValues(view: PlayerView?, interactor: PlayerInteractorInput?, router: PlayerViewRouter?, episode: EpisodeObject?, audioPlayer: AudioPlayerSessionProtocol?, playedDuration: Double? = 0){
        self.episode = episode
        self.view = view
        self.interactor = interactor
        self.router = router
        self.audioPlayer = audioPlayer
    }
    
    func viewDidLoad() {
        // set recently played
        setEpisodeData()
        
        // configure audio player
        setPlayerAudioURL()
        audioPlayer?.setupPlayer()
        
        if playedDuration != nil, let playedDuration = playedDuration {
            view?.updatePlaybackTime(time: formulateDuration(duration: Int(playedDuration)))
            view?.updateSliderValue(value: Float(playedDuration))
            audioPlayer?.seekToVal(value: playedDuration)
        }
        
        checkIfLoved()
    }
    
    func playPausePressed() {
        
        if isFinished {
            isFinished = false
            view?.updatePlayPauseImage(with:"pause.circle.fill")
            audioPlayer?.setupPlayer()
            return
        }
        
        if isPlaying{
            
            isPlaying = false
            view?.updatePlayPauseImage(with: "play.circle.fill")
            audioPlayer?.pausePlaying()
        }
        else{
            isPlaying = true
            view?.updatePlayPauseImage(with:"pause.circle.fill")
            audioPlayer?.startPlaying()
        }
    }
    
    func backwardPressed(currentTime: Float){
        audioPlayer?.seekToVal(value: Double(currentTime - 10))
    }
    
    func forwardPressed(currentTime: Float) {
        audioPlayer?.seekToVal(value: Double(currentTime + 10))
    }
    
    func bookmarkPressed(){
        
        if isLoved{
            setNonLovedEpisode()
        }
        else{
          setLovedEpisode()
        }
    }
    
    func backPressed() {
        audioPlayer?.pausePlaying()
        audioPlayer?.getPLayedDuration()
        newRecentlyPlayedEpisode()
        playerView?.playerViewWillDisappear()
        router?.dismissPlayerVC()
    }
    
    func sliderValueChanged(value: Float) {
        audioPlayer?.seekToVal(value: Double(value))
    }
    
}


//MARK:- Setting player view episode data
extension PlayerPresenter {
    
    private func setEpisodeData(){
        
        if let imageURL = URL(string: episode?.image ?? ""){
            view?.displayEpisodeImage(url: imageURL)
        }
        
        let episodeTitle = episode?.title ?? ""
        view?.displayEpisodeTitle(title: episodeTitle)
        
        let podcastTitle = episode?.podcast?.title ?? ""
        view?.displayPodcastTitle(title: podcastTitle)
        
        let publisher = episode?.podcast?.publisher ?? ""
        view?.displayPublisherName(publisher: publisher)
        
        let duration = formulateDuration(duration: episode!.audio_length_sec)
        view?.displayDuration(duration: duration)
        
        let audioLengthSec = Float(episode!.audio_length_sec)
        view?.setMaxSliderVal(value: audioLengthSec)
    }
    
    private func formulateDuration(duration: Int) -> String{
        
        let durationMin = duration / 60
        let durationSec = duration % 60
        var durationString = ""
        
        
        durationString.append(String(format: "%02d", durationMin) + ":" + String(format: "%02d", durationSec))
        return durationString
    }
}


//MARK:- Setting audioplayer date

extension PlayerPresenter{
    
    private func setPlayerAudioURL(){
        
        guard let urlString = episode?.audio else{
            view?.viewErrorAlert(title: "Error", message: "Something went wrong", actionTitle: "OK")
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        audioPlayer?.setAudioURL(url: url)
    }
}

extension PlayerPresenter: AudioPlayerUpdaterProtocol{

    func error(with errorMessage: String) {
        
        view?.viewErrorAlert(title: "Error", message: errorMessage, actionTitle: "OK", actionHandler: { [weak self](_) in
            self?.router?.dismissPlayerVC()
        })
        
    }
    
    func updatesCurrentPlaybackTime(value: Double?){
        
        guard let value = value else {
            return
        }
        
        let currentPlayTime = formulateDuration(duration: Int(value))
        view?.updatePlaybackTime(time: currentPlayTime)
        view?.updateSliderValue(value: Float(value))
    }
    
    func didFinishPlaying(){
        isPlaying = false
        isFinished = true
        view?.updatePlayPauseImage(with: "play.circle.fill")
        view?.updateSliderValue(value: 0)
        view?.updatePlaybackTime(time: "00:00")
    }
    
    func setPlayedDuration(duration: Double) {
        self.playedDuration = duration
    }
    
}

//MARK:- RecentlyPlayed episodes
extension PlayerPresenter {
    
    
    func newRecentlyPlayedEpisode(){
        
        let recentlyPLayedEpisode = RecentlyPlayedEpisodeModel()
        
        guard let id = episode?.id else {
            return
        }
        
        //episode object
        recentlyPLayedEpisode.id = id
        recentlyPLayedEpisode.audioLink = episode?.audio ?? ""
        recentlyPLayedEpisode.image = episode?.image
        recentlyPLayedEpisode.audio_length_sec = episode?.audio_length_sec ?? 0
        recentlyPLayedEpisode.title = episode?.title ?? ""
        recentlyPLayedEpisode.playedDuration = playedDuration
        // podcast object
        let recentlyPlayedPodcast = RecentlyPlayedPodcastModel()
        
        guard let podcastId = episode?.podcast?.id else {
            recentlyPLayedEpisode.podcast = nil
            addNew(recentlyPlayed: recentlyPLayedEpisode)
            return
        }
        
        recentlyPlayedPodcast.id = podcastId
        recentlyPlayedPodcast.title = episode?.podcast?.title ?? ""
        recentlyPlayedPodcast.image = episode?.podcast?.image
        recentlyPlayedPodcast.info = episode?.podcast?.description
        recentlyPlayedPodcast.publisher = episode?.podcast?.publisher
        recentlyPlayedPodcast.total_episodes = episode?.podcast?.total_episodes
        recentlyPlayedPodcast.genre_ids.append(objectsIn:(episode?.podcast?.genre_ids) ?? [0])
        
        recentlyPLayedEpisode.podcast = recentlyPlayedPodcast
        
        addNew(recentlyPlayed: recentlyPLayedEpisode)
    }
    
    private func addNew(recentlyPlayed: RecentlyPlayedEpisodeModel?){
        
        guard let episode = recentlyPlayed else{
            return
        }
        
        interactor?.addNew(recentlyPlayed: episode)
    }
    
}

//MARK:- Loved episode function
extension PlayerPresenter {
    
    private func setNonLovedEpisode(){
        isLoved = false
        view?.updateLoveButton(with: "heart")
        removeFromLoved()
    }
    
    private func setLovedEpisode(){
        isLoved = true
        view?.updateLoveButton(with: "heart.fill")
        addToLoved()
    }
    
    
    private func addToLoved(){
        
        let lovedEpisode = LovedEpisode()
        
        guard let id = episode?.id else{
            view?.viewErrorAlert(title: "Failure", message: "something went wrong", actionTitle: "OK")
            return
        }
        
        lovedEpisode.id = id
        lovedEpisode.image = episode?.image ?? ""
        lovedEpisode.title = episode?.title ?? ""
        lovedEpisode.audio_length_sec = episode!.audio_length_sec
        lovedEpisode.audioLink = episode?.audio
        
        interactor?.addToLovedList(lovedEpisode: lovedEpisode)
    }
    
    
    private func removeFromLoved(){
        
        guard let id = episode?.id else {
            return
        }
        
        interactor?.removeFromLovedList(id: id, type: LovedEpisode.self)
    }
    
    private func checkIfLoved(){
        interactor?.isExistInLovedList(id: episode?.id ?? "")
    }

}

extension PlayerPresenter: PlayerInteractorOutput{
    
    func existedInLovedList(existed: Bool){
        
        if existed {
            setLovedEpisode()
        }
        else{
            setNonLovedEpisode()
        }
    }
    
    func failed(with error: String) {
        view?.viewErrorAlert(title: "Failure", message: error, actionTitle: "OK")
    }
    
}


