//
//  PodcastDetailsPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import Foundation

class PodcastDetailsPresenter: PodcastDetailsViewPresenter {

    weak var view: PodcastDetailsView?
    var router: PodcastDetailsViewRouter?
    var interactor: PodcastDetailsInteractorInput?
    var podcastDetails: PodcastDetailsObject?
    var localInteractor: PodcastDetailsLocalInteractorInput?

    var podcast: PodcastObject?
    private var isLoved: Bool = false
    
    weak var podcastViewDelegate: PodcastViewDelegate?
    
    
    required init(view: PodcastDetailsView?, router: PodcastDetailsViewRouter?, interactor: PodcastDetailsInteractorInput?, podcast: PodcastObject, localInteractor: PodcastDetailsLocalInteractorInput?) {
        
        self.view = view
        self.router = router
        self.podcast = podcast
        self.interactor = interactor
        self.localInteractor = localInteractor
    }

    
    func viewDidLoad() {
        view?.showLoader()
        getPodcastDetails()
        checkIfLoved()
    }
    
    private func setPodcastDetailsData(){
        
        DispatchQueue.main.async {
            
            self.view?.displayPodcastPoster(with: URL(string: self.podcast?.image ?? ""))
            self.view?.displayPodcastTitle(title: self.podcast?.title ?? "")
            
            let episodeNumber = "\(self.podcastDetails?.episodes.count ?? 0) ● Episodes"
            self.view?.displayEpisodeNumber(number: episodeNumber)

            self.view?.displayPodcastPublisher(publisher: self.podcast?.publisher ?? "")
            
            var description = self.podcastDetails?.description ?? ""
            description = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            self.view?.displayPodcastDescription(description: description)
                        
            //After assigning all data
            self.view?.updateScrollViewHeight()
        }
        
        view?.reloadEpisodesTableView()
        view?.hideLoader()
    }
    
    func viewWillDisapear(){
        podcastViewDelegate?.podcastViewWillDisappear()
    }
    
    private func checkIfLoved(){
        localInteractor?.isExistInLovedList(id: podcast?.id ?? "")
    }
}

//MARK:-  table view logic
extension PodcastDetailsPresenter{
    
    func tableViewCount() -> Int {
        return podcastDetails?.episodes.count ?? 0
    }
    
    func configureCell(at indexPath: Int, for cell: PodcastDetailsEpisodesCellProtocol) {
        
        let cellData = podcastDetails?.episodes[indexPath]
        cell.displayEpisode(title: cellData?.title ?? "")
        
        if let url =  URL(string: cellData?.image ?? ""){
            cell.displayEpisodeImage(with: url)
        }
    }
    
    func didSelectCell(at indexPath: Int){
      
        guard let episode = podcastDetails?.episodes[indexPath] else {
            return
        }
        
        let selectedEpisode = EpisodeObject(
            id: episode.id,
            title: episode.title,
            audio: episode.audio,
            description: episode.description,
            image: episode.image,
            audio_length: episode.audio_length_sec,
            podcast: podcast
        )
        
        router?.moveToPlayer(with: selectedEpisode)
    }
}

//MARK:- Getting podcast details data
extension PodcastDetailsPresenter{
    
    private func getPodcastDetails(){
        
        guard let podcastId = podcast?.id else{
            return
        }
        
        let sortType = "recent_first"
        interactor?.getPodcastDetails(with: podcastId, sort: sortType)
    }
}

//MARK:- interactor output protocol functions
extension PodcastDetailsPresenter: PodcastDetailsInteractorOutput {
    
    func success(with podcastDetails: PodcastDetailsObject) {
        self.podcastDetails = podcastDetails
        setPodcastDetailsData()
    }
    
    func failed(with error: Error) {
        self.view?.hideLoader()        
        view?.showErrorAlert(title: "Failed", message: "Something went wrong", actionTitle: "OK", actionHandler: {[weak self] _ in
            self?.router?.popViewController()
        })
    }
}


extension PodcastDetailsPresenter{
    
    func lovePressed() {
        
        if isLoved{
             setNonLovedPodcastView()
            localInteractor?.removePodcastFromLovedPodcast(type: LovedPodcastModel.self, id: (podcast?.id)!)
        }
        else{
            setLovedPodcastView()
            
            let lovedPodcast = convertToLoved(podcast: podcast!)
            localInteractor?.addPodcastToLovedPodcast(type: LovedPodcastModel.self, object: lovedPodcast)
        }
    }
    
    private func setNonLovedPodcastView(){
        isLoved = false
        view?.updateLovedImage(with: "heart")
        view?.updateNormalLovedTint()
    }
    
    private func setLovedPodcastView(){
        isLoved = true
        view?.updateLovedImage(with: "heart.fill")
        view?.updateSelectedLovedTint()
    }
    
    func sharePressed() {
       
        guard let urlString = podcast?.listennotes_url else{ return }
        guard let url = URL(string: urlString) else{ return }
        router?.viewActivityVC(with: url)
    }
    
    private func convertToLoved(podcast: PodcastObject) -> LovedPodcastModel{
        
        let lovedObject = LovedPodcastModel()
        lovedObject.id = podcast.id
        lovedObject.title = podcast.title
        lovedObject.info = podcast.description
        lovedObject.image = podcast.image
        lovedObject.publisher = podcast.publisher
        lovedObject.total_episodes = podcast.total_episodes
        lovedObject.genre_ids.append(objectsIn: podcast.genre_ids ?? [])
        lovedObject.listennotes_url = podcast.listennotes_url
        return lovedObject
    }
}

extension PodcastDetailsPresenter: PodcastDetailsLocalInteractorOutput{
  
    func success(with process: Bool) {
        print(process)
    }
    
    func error(with message: String) {
        view?.showErrorAlert(title: "Failure", message: message, actionTitle: "OK",actionHandler: { [weak self](_) in
            self?.lovePressed()
        })
    }

    func existedInLovedList(existed: Bool) {
        if existed {
            setLovedPodcastView()
        }
    }
}
