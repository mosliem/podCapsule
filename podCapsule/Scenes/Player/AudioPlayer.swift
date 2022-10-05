//
//  AudioPlayer.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/29/22.
//

import AVFoundation
import MediaPlayer


class AudioPlayer: AudioPlayerSessionProtocol {
    
    weak var presenter: AudioPlayerUpdaterProtocol?
    
    private var audioSession: AVAudioSession?
    private var audioPlayer: AVPlayer?
    private var audioURL: URL?
    private var playbackTimeUpdater: Timer?
    
    deinit {
        print("deinit audioplayer")
        self.audioSession = nil
        self.audioURL = nil
        self.audioPlayer = nil
        self.playbackTimeUpdater = nil
        removeEndPlayingObserver()
    }
   
    //MARK:- protocol functions
    
    func setAudioURL(url: URL) {
        self.audioURL = url
    }
    
    func setupPlayer() {
        setupAudioSession()
        setupAudioPlayer()
    }
    
    func startPlaying() {
        
        audioPlayer?.play()
        updatePlaybackTime()
    }
    
    func pausePlaying() {
        audioPlayer?.pause()
        removeTimeUpdater()
    }
    
    
    func seekToVal(value: Double){
        
        audioPlayer?.seek(to: CMTime(seconds: value, preferredTimescale: 1000), completionHandler: { [weak self] (result) in
            if result && value <= (self?.audioPlayer!.currentItem!.duration.seconds)!{
                self?.presenter?.updatesCurrentPlaybackTime(value: value)
            }
        })
    }
    
    func getPLayedDuration() {
        let duration = audioPlayer?.currentItem?.currentTime().seconds
        presenter?.setPlayedDuration(duration: duration ?? 0)
    }
    
}

//MARK:- private functions 
extension AudioPlayer{
    
    private func setupAudioSession(){
        
        audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession?.setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession?.setCategory(.playback, mode: .default)
        }
        catch{
            presenter?.error(with: "something went wrong!")
        }
    }
    
    private func setupAudioPlayer(){
        
        guard let url = audioURL else {
            return
        }
        
        audioPlayer = AVPlayer(url: url)
        
        addEndPlayingObserver()
        startPlaying()
        
    }
    
    @objc func didFinishPlayingItem(){
        
        removeTimeUpdater()
        presenter?.didFinishPlaying()
        removeEndPlayingObserver()
    }
    
    private func updatePlaybackTime(){
        
        playbackTimeUpdater = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self](_) in
            
            if self?.audioPlayer?.currentItem?.status == .readyToPlay{
                
                let time = self?.audioPlayer?.currentItem?.currentTime().seconds
                
                if  time! <= (self!.audioPlayer!.currentItem?.asset.duration.seconds)! {
                    self?.presenter?.updatesCurrentPlaybackTime(value: time)
                }
            }
        }
    }
    
    private func removeTimeUpdater(){
        playbackTimeUpdater?.invalidate()
    }
    
    private func addEndPlayingObserver(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didFinishPlayingItem),
            name: .AVPlayerItemDidPlayToEndTime,
            object: audioPlayer?.currentItem
        )
    }
    
    private func removeEndPlayingObserver(){
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: audioPlayer?.currentItem
        )
    }
}

