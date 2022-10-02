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
    var router: HomeViewRouter?
    
    private var region: String?
    
    private var selectedCategories = [CategoryModel]()
    private var popularPodcasts = [HomePodcastResponse]()
    private var recentlyPlayed = [RecentlyPlayedEpisodeModel]()
    private var randomEpisodes = [RandomEpisodesResponse]()
    private var categoriesBestPodcasts = [String: [HomePodcastResponse]]()
    
    private var fetchGroup = DispatchGroup()
    
    
    required init(view: HomeView, networkInteractor: HomeNetworkInteractorInputProtocol, localInteractor: HomeLocalInteractorInput, router: HomeViewRouter) {
        self.view = view
        self.networkInteractor = networkInteractor
        self.localInteractor = localInteractor
        self.router = router
    }
    
    func viewWillAppear(){
        fetchGroup.enter()
        fetchRecentlyPlayedEpisode()
    }
    
    func viewDidLoad() {
        print("viewDidLoad")
        getPreferences()
        fetchPodcasts()
        
    }
    
    private func fetchPodcasts(){
        
        fetchGroup.enter()
        fetchGroup.enter()
        
        networkInteractor?.fetchPopularPodcast()
        networkInteractor?.fetchRandomEpisodes()
        fetchCategoriesPodcasts()
        
        fetchGroup.notify(queue: .main){
            self.view?.reloadHomeCollectionView()
        }
    }
    
    private func getPreferences(){
        localInteractor?.getCategories()
        localInteractor?.getRegion()
    }
    
    private func fetchCategoriesPodcasts(){
        
        for category in selectedCategories {
            fetchGroup.enter()
            networkInteractor?.fetchBestForCategory(genre_id: category.categoryId, pageNum: 1, region: region!)
        }
    }
    
    func numberOfSections() -> Int {
        return selectedCategories.count + 3
    }
    
    func itemsForSection(for section: Int) -> Int {
        
        if section < 3{
            
            switch HomeSections.sectionForIndex(index: section){
            
            case .RecentlyPlayed:
                return recentlyPlayed.count
            case .PopularPodcasts:
                return popularPodcasts.count
            case .JustListen:
                return randomEpisodes.count
            }
        }
        else{
            
            let categoryName = selectedCategories[section - 3].categoryName
            
            let categoryPodcasts = categoriesBestPodcasts[categoryName]
            return categoryPodcasts?.count ?? 0
        }
    }
    
    func heightForRecentlyPlay() -> Double {
        
        if recentlyPlayed.count != 0{
            return 60
        }
        else{
            return 0
        }
    }
    
    func titleForSection(for section: Int, header: HomeCollectionReusableViewInput){
        
        //Main sections
        if section < 3{
            let title = HomeSections.titleForIndex(index: section)  ?? ""
            header.dispalySectionTitle(text: title)
        }
        else{
            // categories sections
            let index = section - 3
            let title = selectedCategories[index].categoryName
            header.dispalySectionTitle(text: title)
            
        }
    }
    
    private func fetchRecentlyPlayedEpisode(){
        localInteractor?.getRecentlyPlayed()
    }
}

//MARK:- cell configuring

extension HomePresenter{
    
    func configureCell<T> (at section: Int, for indexPath: Int, cell: T){
        
        if section < 3 {
            switch HomeSections.sectionForIndex(index: section) {
            
            case .RecentlyPlayed:
                let cellData = recentlyPlayed[indexPath]
                setRecentlyPlayedEpisodeDate(for: cell as! RecentlyPlayedCellView, cellData: cellData)
                
            case .PopularPodcasts:
                let cellData = popularPodcasts[indexPath]
                setPodcastData(for: cell as! PodcastCellView, cellData: cellData)
                
            case .JustListen:
                let cellData = randomEpisodes[indexPath]
                setRandomEpisodeData(for: cell as! PodcastCellView, cellData: cellData)
            }
        }
        else{
            
            let categoryName = selectedCategories[section - 3].categoryName
            
            guard let categoryPodcasts = categoriesBestPodcasts[categoryName] else {
                return
            }
            
            let podcastData = categoryPodcasts[indexPath]
            setPodcastData(for: cell as! PodcastCellView, cellData: podcastData)
        }
    }
    
    private func setPodcastData(for cell: PodcastCellView, cellData: HomePodcastResponse){
        
        let title =  cellData.title
        let imageURL =  cellData.image
        cell.displayName(for: title)
        
        if let imageURL = imageURL {
            cell.displayPosterImage(urlString: imageURL)
        }
        
    }
    
    private func setRandomEpisodeData(for cell: PodcastCellView,cellData: RandomEpisodesResponse){
        
        let title =  cellData.title
        let imageURL = cellData.image
        cell.displayName(for: title)
        
        if let imageURL = imageURL {
            cell.displayPosterImage(urlString: imageURL)
        }
        
    }
    // recntly played cell func
    
    private func setRecentlyPlayedEpisodeDate(for cell: RecentlyPlayedCellView, cellData: RecentlyPlayedEpisodeModel){
        
        let title = cellData.title
        let imageURLString = cellData.image
        
        cell.displayName(for: title)
        
        if let imageURL = URL(string: imageURLString ?? "") {
            cell.displayPosterImage(url: imageURL)
        }
        else{
            cell.displayDefualtPoster(string: "EP")
        }
    }
    
}

//MARK:- Cell selection action logic
extension HomePresenter{
    
    func cellSelected(at section: Int, row: Int) {
        
        if section < 3{
            switch HomeSections.sectionForIndex(index: section) {
            
            case .RecentlyPlayed:
                
                let episode = recentlyPlayed[row]
                let playerEpisode = convertTo(type: RecentlyPlayedEpisodeModel.self, object: episode, convertedType: EpisodeObject.self)
                router?.moveToPlayer(with: playerEpisode, playedDuration: episode.playedDuration)
                
            case .PopularPodcasts:
                let podcast = popularPodcasts[row]
                let podcastDetails = convertTo(type: HomePodcastResponse.self, object: podcast, convertedType: PodcastObject.self)
                router?.moveToPodcastDetails(with: podcastDetails)
            case .JustListen:
                
                let episode = randomEpisodes[row]
                let playerEpisode = convertTo(type: RandomEpisodesResponse.self, object: episode, convertedType: EpisodeObject.self)
                router?.moveToPlayer(with: playerEpisode)
            }
        }
        else{
            
            let categoryName = selectedCategories[section - 3].categoryName
            
            guard let categoryPodcasts = categoriesBestPodcasts[categoryName]  else {
                return
            }
            
            let podcast = categoryPodcasts[row]
            let podcastDetails = convertTo(type: HomePodcastResponse.self, object: podcast, convertedType: PodcastObject.self)
            router?.moveToPodcastDetails(with: podcastDetails)
        }
    }
    
    // Genric function to convert to player and podcast details models
    /// because of server model conflicts
    private func convertTo <T,C> (type: T.Type, object: T, convertedType: C.Type) -> C {
        
        if type == RecentlyPlayedEpisodeModel.self {
            
            let object = object as! RecentlyPlayedEpisodeModel
            let convertedObject = EpisodeObject(id: object.id, title: object.title, audio: object.audioLink, description: object.description, image: object.image, audio_length: object.audio_length_sec, podcast: nil)
            return convertedObject as! C
            
        }
        else if type == RandomEpisodesResponse.self {
            
            let object = object as! RandomEpisodesResponse
            let convertedObject = EpisodeObject(id: object.id, title: object.title, audio: object.audio, description: object.description, image: object.image, audio_length: object.audio_length_sec)
            
            return convertedObject as! C
        }
        else{
            
            let object = object as! HomePodcastResponse
            let convertedObject = PodcastObject(id: object.id, title: object.title, publisher: object.publisher, image: object.image, description: nil, total_episodes: nil, genre_ids: nil)
            
            return convertedObject as! C
        }
    }
}

//MARK:- results of the podcast from network interactor

extension HomePresenter: HomeNetworkInteractorOutputProtocol{
    
    func popularPodcastFetched(podcasts: PopularPodcasts) {
        defer {
            fetchGroup.leave()
        }
        
        for podcast in podcasts.curated_lists{
            popularPodcasts.append(contentsOf: podcast.podcasts)
        }
    }
    
    func randomEpisodesFetched(episodes: [RandomEpisodesResponse]) {
        defer {
            fetchGroup.leave()
        }
        randomEpisodes = episodes
    }
    
    func failedWith(with error: Error) {
        
        defer {
            fetchGroup.leave()
        }
        print(error.localizedDescription)
    }
    
    func bestForCategoryFetched(podcasts: BestPodcastsObject) {
        
        defer {
            fetchGroup.leave()
        }
        
        let categoryName = podcasts.name
        categoriesBestPodcasts.updateValue(podcasts.podcasts, forKey: categoryName)
    }
    
}

//MARK:- results of the local podcasts data

extension HomePresenter: HomeLocalInteractorOutput{
    
    func success(with country: String) {
        region = country.lowercased()
    }
    
    func failed(with error: Error) {
        print(error.localizedDescription)
    }
    
    
    func success(with categories: [CategoryModel]) {
        self.selectedCategories = categories
    }
    
    func success(with recentlyPlayed: [RecentlyPlayedEpisodeModel]){
        
        defer {
            fetchGroup.leave()
        }
        self.recentlyPlayed = recentlyPlayed
        view?.reloadHomeCollectionView()
    }
    
    
}

extension HomePresenter: PlayerViewDelegate {
    func playerViewWillDisappear() {
        viewWillAppear()
    }
}
