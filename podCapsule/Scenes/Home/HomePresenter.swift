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
    
    private var region: String?
    private var selectedCategories = [CategoryModel]()
    private var popularPodcasts = [PodcastObject]()
    private var recentlyPlayed = [PodcastObject]()
    private var randomEpisodes = [EpisodeObject]()
    private var categoriesBestPodcasts = [String: [PodcastObject]]()
    
    private var fetchGroup = DispatchGroup()
    
    
    required init(view: HomeView?, networkInteractor: HomeNetworkInteractorInputProtocol?, localInteractor: HomeLocalInteractorInput) {
        self.view = view
        self.networkInteractor = networkInteractor
        self.localInteractor = localInteractor
    }
    
    func viewDidLoad() {
        
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
                return 0
            case .PopularPodcasts:
                return popularPodcasts.count
            case .JustListen:
                return randomEpisodes.count
            }
        }
        else{
            
            let categoryName = selectedCategories[section - 3].categoryName
            
            let categoryPodcasts = categoriesBestPodcasts[categoryName]
            print(categoryName, categoryPodcasts?.count)
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
    
    
    func configureCell<T> (at section: Int, for indexPath: Int, cell: T){
        
        if section < 3 {
            switch HomeSections.sectionForIndex(index: section) {
            
            case .RecentlyPlayed:
                break
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
            
            guard let categoryPodcasts = categoriesBestPodcasts[categoryName]  else {
                return
            }
            
            let podcastData = categoryPodcasts[indexPath]
            setPodcastData(for: cell as! PodcastCellView, cellData: podcastData)
        }
    }
    
    private func setPodcastData(for cell: PodcastCellView, cellData: PodcastObject){
        
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
    
}


extension HomePresenter: HomeNetworkInteractorOutputProtocol{
    
    func popularPodcastFetched(podcasts: [PodcastObject]) {
        defer {
            fetchGroup.leave()
        }
        
        popularPodcasts = podcasts.shuffled()
    }
    
    func randomEpisodesFetched(episodes: [EpisodeObject]) {
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
    
    
}
