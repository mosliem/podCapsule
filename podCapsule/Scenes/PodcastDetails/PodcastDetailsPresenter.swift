//
//  PodcastDetailsPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import Foundation

class PodcastDetailsPresenter: PodcastDetailsViewPresenter {

    var view: PodcastDetailsView?
    var router: PodcastDetailsViewRouter?
    var interactor: PodcastDetailsInteractorInput?
    var podcast: PodcastObject?
    var podcastDetails: PodcastDetailsObject?
    
    required init(view: PodcastDetailsView?, router: PodcastDetailsViewRouter?, interactor: PodcastDetailsInteractorInput?, podcast: PodcastObject) {
        self.view = view
        self.router = router
        self.podcast = podcast
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.showLoader()
        
        getPodcastDetails()
    }
    
    private func setPodcastDetailsData(){
        
        view?.displayPodcastPoster(with: URL(string: podcast?.image ?? ""))
        view?.displayPodcastTitle(title: podcast?.title ?? "")
        
        view?.displayPodcastPublisher(publisher: podcast?.publisher ?? "")
        view?.displayPodcastDescription(description: podcastDetails?.description ?? "")
        
        let episodeNumber = "\(String(describing: podcastDetails?.episodes.count)) - Episodes"
        view?.displayEpisodeNumber(number: episodeNumber)
        view?.updateScrollViewHeight()
    }
}

extension PodcastDetailsPresenter{
    
    func tableViewCount() -> Int {
        
    }
    
    func configureCell(at indexPath: Int) {
        
    }
    

}

extension PodcastDetailsPresenter{
    
    private func getPodcastDetails(){
        
        guard let podcastId = podcast?.id else{
            return
        }
        
        let sortType = "recent_first"
        interactor?.getPodcastDetails(with: podcastId, sort: sortType)
    }
}

extension PodcastDetailsPresenter: PodcastDetailsInteractorOutput {
   
    func success(with podcastDetails: PodcastDetailsObject) {
        self.podcastDetails = podcastDetails
        setPodcastDetailsData()
        
    }

    func failed(with error: Error) {
        
    }
}

