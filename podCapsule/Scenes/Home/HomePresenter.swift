//
//  HomePresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import Foundation

class HomePresenter: HomeViewPresenter{
    
    weak var view: HomeView?
    var networkInteractor: HomeNetworkInteractorInputProtocol?
    var localInteractor: HomeLocalInteractorInput?
    var categories = [CategoryModel]()
    
    private var popularPodcasts = [PodcastObject]()
    private var recentlyPlayed = [PodcastObject]()
    private var randomEpisodes = [EpisodeObject]()
    
    required init(view: HomeView?, networkInteractor: HomeNetworkInteractorInputProtocol?, localInteractor: HomeLocalInteractorInput) {
        self.view = view
        self.networkInteractor = networkInteractor
        self.localInteractor = localInteractor
    }
    
    func viewDidLoad() {
        
        localInteractor?.getCategories()
        //        networkInteractor?.fetchPopularPodcast()
        //        interactor?.fetchRandomEpisodes()
        
    }
    
    
    func numberOfSections() -> Int {
        return categories.count + 3
    }
    
    func itemsForSection(for section: Int) -> Int {
        
        if section < 3{
            
            switch HomeSections.sectionForIndex(index: section){
            
            case .RecentlyPlayed:
                return 0
            case .PopularPodcasts:
                return popularPodcasts.count
            case .JustListen:
                return randomEpisodes.count
            }
        }
        else{
            return 10
        }
    }
    
    func titleForSection(for section: Int, header: HomeCollectionReusableViewInput){
        
        if section < 3{
            let title = HomeSections.titleForIndex(index: section)  ?? ""
            header.dispalySectionTitle(text: title)
        }
        else{
            
            let index = section - 3
            let title = categories[index].categoryName
            header.dispalySectionTitle(text: title)
            
        }
    }
    
    
    func configureCell<T> (at section: Int, for indexPath: Int, cell: T){
        
        if section < 3 {
            switch HomeSections.sectionForIndex(index: section) {
            
            case .RecentlyPlayed:
                break
            case .PopularPodcasts:
                let cellData = popularPodcasts[indexPath]
                setPopularPodcastData(for: cell as! PodcastCellView, cellData: cellData)
                
            case .JustListen:
                let cellData = randomEpisodes[indexPath]
                setRandomEpisodeData(for: cell as! PodcastCellView, cellData: cellData)
            }
        }
        else{
           
            
        }
    }
    
    private func setPopularPodcastData(for cell: PodcastCellView, cellData: PodcastObject){
        
        let title =  cellData.title
        let image =  cellData.image
        cell.displayName(for: title)
        cell.displayPosterImage(urlString: image)
    }
    
    private func setRandomEpisodeData(for cell: PodcastCellView,cellData: EpisodeObject){
        
        let title =  cellData.title
        let image =  cellData.image
        cell.displayName(for: title)
        cell.displayPosterImage(urlString: image)
    }
    
    
    func heightForRecentlyPlay() -> Double {
        
        if recentlyPlayed.count != 0{
            return 60
        }
        else{
            return 0
        }
    }
    
}


extension HomePresenter: HomeNetworkInteractorOutputProtocol{
    
    
    func popularPodcastFetched(podcasts: [PodcastObject]) {
        popularPodcasts = podcasts.shuffled()
        view?.reloadHomeCollectionView()
    }
    
    func randomEpisodesFetched(episodes: [EpisodeObject]) {
        randomEpisodes = episodes
        view?.reloadHomeCollectionView()
    }
    
    
    func failedWith(with error: Error) {
        print(error.localizedDescription)
    }
    
    
}

extension HomePresenter: HomeLocalInteractorOutput{
    
    func failed(with error: Error) {
        
    }
    
    
    func success(with categories: [CategoryModel]) {
        self.categories = categories
    }
    
    
}
