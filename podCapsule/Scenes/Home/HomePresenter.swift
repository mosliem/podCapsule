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
    
    private var sections = [String]()
    private var addedSection = [String: Bool]()
    
    required init(view: HomeView, networkInteractor: HomeNetworkInteractorInputProtocol, localInteractor: HomeLocalInteractorInput, router: HomeViewRouter) {
        self.view = view
        self.networkInteractor = networkInteractor
        self.localInteractor = localInteractor
        self.router = router
    }
    
    func viewWillAppear(){
       getRecentlyPlayed()
    }
    
    func viewDidLoad() {
        view?.showLoader()
        getPreferences()
        fetchPodcasts()
    }
    
    private func getRecentlyPlayed(){
        fetchGroup.enter()
        localInteractor?.getRecentlyPlayed()

        fetchGroup.notify(queue: .main){
            self.setViewSectionsLayout()
        }
    }
    
    private func fetchPodcasts(){
        fetchGroup.enter()
        fetchGroup.enter()
        
        networkInteractor?.fetchPopularPodcast()
        networkInteractor?.fetchRandomEpisodes()
        fetchCategoriesPodcasts()
    }
    
    private func setViewSectionsLayout(){
        var allSections = sections
        if !sections.isEmpty && addedSection[sections[0]] == nil && sections[0] == "Recently Played"{
            addedSection.updateValue(true, forKey: sections[0])
            view?.addRecentlyPlayedSection()
            allSections.remove(at: 0)
        }
        
        for section in allSections {
            if addedSection[section] == nil{
                addedSection.updateValue(true, forKey: section)
                view?.addPodcastSection()
            }
        }
        
        view?.assignCollectionViewLayout()
        view?.reloadHomeCollectionView()
        view?.hideLoader()
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
        return sections.count
    }
    
    func itemsForSection(for section: Int) -> Int {
        
        if sections[section] == "Recently Played"{
            return recentlyPlayed.count
        }
        else if sections[section] == "Popular Podcasts"{
            return popularPodcasts.count
        }
        else if sections[section] == "Just Listen"{
            return randomEpisodes.count
        }
        else{
            let sectionName = sections[section]
            return categoriesBestPodcasts[sectionName]?.count ?? 0
        }
    }

    
    func titleForSection(for section: Int, header: SectionsCollectionReusableViewInput){
        header.dispalySectionTitle(text: sections[section])
    }
    
    func cellType<T>(for section: Int) -> T {
        
        if sections[section] == "Recently Played"{
            return RecentlyPlayedCell.self as! T
        }
        else{
            return PodcastCell.self as! T
        }
        
    }
    
    private func fetchRecentlyPlayedEpisode(){
        localInteractor?.getRecentlyPlayed()
    }
    
}

//MARK:- cell configuring

extension HomePresenter{
    
    func configureCell<T> (at section: Int, for indexPath: Int, cell: T){

        if sections[section] == "Recently Played"{
            let cellData = recentlyPlayed[indexPath]
            setRecentlyPlayedEpisodeData(for: cell as! RecentlyPlayedCellView, cellData: cellData)
        }
        else if sections[section] == "Popular Podcasts"{
            let cellData = popularPodcasts[indexPath]
            setPodcastData(for: cell as! PodcastCellView, cellData: cellData)
        }
        else if sections[section] == "Just Listen"{
            let cellData = randomEpisodes[indexPath]
            setRandomEpisodeData(for: cell as! PodcastCellView, cellData: cellData)
        }
        else{
            
            let categoryName = sections[section]
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
    private func setRecentlyPlayedEpisodeData(for cell: RecentlyPlayedCellView, cellData: RecentlyPlayedEpisodeModel){
        
        let title = cellData.title
        let imageURLString = cellData.image
        
        cell.displayName(for: title)
        
        let remainingDuration = cellData.audio_length_sec - Int(cellData.playedDuration ?? 0)
        
        if remainingDuration > 0 && remainingDuration / 60 > 0 {
            cell.displayRemainingTime(time: String(remainingDuration / 60) + " mins remaining")
        }
        else if remainingDuration > 0 && remainingDuration / 60 < 0 {
            cell.displayRemainingTime(time:"less than min remaining")
        }
        
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
        if sections[section] == "Recently Played"{
            let episode = recentlyPlayed[row]
            let playerEpisode = convertTo(type: RecentlyPlayedEpisodeModel.self, object: episode, convertedType: EpisodeObject.self)
            router?.moveToPlayer(with: playerEpisode, playedDuration: episode.playedDuration)
        }
        else if sections[section] == "Just Listen"{
            let episode = randomEpisodes[row]
            let playerEpisode = convertTo(type: RandomEpisodesResponse.self, object: episode, convertedType: EpisodeObject.self)
            router?.moveToPlayer(with: playerEpisode)
        }
        else if sections[section] == "Popular Podcasts"{
            let podcast = popularPodcasts[row]
            let podcastDetails = convertTo(type: HomePodcastResponse.self, object: podcast, convertedType: PodcastObject.self)
            router?.moveToPodcastDetails(with: podcastDetails)
        }
        else{
            
            let categoryName = sections[section]
            guard let categoryPodcasts = categoriesBestPodcasts[categoryName] else {
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
    
            let podcast = object.podcast!
     
            var genres = [Int]()
            genres = podcast.genre_ids.toArray(type: Int.self)
            
            let podcastObject = PodcastObject(id: podcast.id, title: podcast.title, publisher: podcast.publisher ?? "", image: podcast.image, description: podcast.description, total_episodes: podcast.total_episodes, genre_ids: genres, listennotes_url: "")
            
            let convertedObject = EpisodeObject(id: object.id, title: object.title, audio: object.audioLink, description: object.description, image: object.image, audio_length: object.audio_length_sec, podcast: podcastObject)
            return convertedObject as! C
            
        }
        else if type == RandomEpisodesResponse.self {
            
            let object = object as! RandomEpisodesResponse
            let podcast = object.podcast!
            let podcastObject = PodcastObject(id: podcast.id, title: podcast.title, publisher: podcast.publisher, image: podcast.image, description: nil, total_episodes: nil, genre_ids: nil, listennotes_url: podcast.listennotes_url )
            
            let convertedObject = EpisodeObject(id: object.id, title: object.title, audio: object.audio, description: object.description, image: object.image, audio_length: object.audio_length_sec, podcast: podcastObject)
            
            return convertedObject as! C
        }
        else{
            
            let object = object as! HomePodcastResponse
            let convertedObject = PodcastObject(id: object.id ?? "", title: object.title, publisher: object.publisher, image: object.image, description: nil, total_episodes: nil, genre_ids: nil, listennotes_url: object.listennotes_url)
            
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
        print(podcasts.curated_lists.count)
        sections.insert("Popular Podcasts", at: 1)
        
    }
    
    func randomEpisodesFetched(episodes: [RandomEpisodesResponse]) {
        defer {
            fetchGroup.leave()
        }
        randomEpisodes = episodes
        
        sections.append("Just Listen")
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
        sections.append(categoryName)
    }
    
}

//MARK:- results of the local podcasts data

extension HomePresenter: HomeLocalInteractorOutput{
    
    func success(with country: String) {
        region = country.lowercased()
    }
    
    func failed(with error: Error) {
        defer {
            fetchGroup.leave()
        }
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

        if sections.isEmpty{
            sections.insert("Recently Played", at: 0)
        }
        else if !sections.isEmpty && sections[0] != "Recently Played"{
           sections.insert("Recently Played", at: 0)
        }
      
    }
}

extension HomePresenter: PlayerViewDelegate {
    func playerViewWillDisappear() {
        viewWillAppear()
    }
}

