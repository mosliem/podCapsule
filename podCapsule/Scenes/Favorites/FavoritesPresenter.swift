//
//  FavoritesPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

class FavoritesPresenter: FavoritesViewPresenter{
    
    weak var view: FavoritesView?
    
    var interactor: FavoritesInteractorInput?
    
    var router: FavoritesViewRouter?
    
    var sectionsHandler: FavoriteSectionsHandler?
    
    var favoritePodcasts = [LovedPodcastModel]()
    var favoriteEpisodes = [LovedEpisode]()
    
    var fetchGroup = DispatchGroup()
    
    required init(view: FavoritesView, interactor: FavoritesInteractorInput, router: FavoritesViewRouter, sectionsHandler: FavoriteSectionsHandler?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.sectionsHandler = sectionsHandler
    }
    
    func viewWillAppear() {
        favoritePodcasts.removeAll()
        favoriteEpisodes.removeAll()
        sectionsHandler?.removeAllSections()
        view?.resetCollectionViewLayout()
        
        view?.showLoader()
        getFavoritesData()
    }
    
    func numberOfSection() -> Int {
        return sectionsHandler?.sectionsCount() ?? 0
    }
    
    func numberOfItems(for section: Int) -> Int{
       
       let section =  sectionsHandler!.typeForIndex(index: section)
        
        switch section {
            case .Episodes:
                return favoriteEpisodes.count
            case .Podcasts:
                return favoritePodcasts.count
        }
        
    }
    
    func type<T>(for section: Int) -> T {
        
        let sectionType =  sectionsHandler!.typeForIndex(index: section)

        switch sectionType {
            case .Podcasts:
                return FavoritePodcastCollectionViewCell.self as! T
            case .Episodes:
                return FavoriteEpisodeCollectionViewCell.self as! T
        }
        
    }
    
    private func getFavoritesData(){
        fetchGroup.enter()
        fetchGroup.enter()
        interactor?.getFavoritePodcasts()
        interactor?.getFavoriteEpisodes()
        
        fetchGroup.notify(queue: .main){
            
            if self.favoriteEpisodes.isEmpty && self.favoritePodcasts.isEmpty{
                self.view?.hideLoader()
                self.view?.showNoFavoritesFound()
            }
            else{
              self.view?.hideNoFavoritesFound()
              self.configureSections()
            }
        }
    }
 
    func configureSections(){
        
        let sections = sectionsHandler!.getSections()

        for section in sections{
            
            switch section {
                case .Podcasts:
                   view?.appendPodcastSectionLayout()
                case .Episodes:
                   view?.appendEpisodeSectionLayout()
            }
        }
        view?.setCollectionSectionsLayout()
        view?.reloadFavoritesData()
        view?.hideLoader() 
    }
    
}

extension FavoritesPresenter{
    
    func titleForSection(at section: Int, header: SectionsCollectionReusableViewInput){
        guard let section = sectionsHandler?.typeForIndex(index: section) else{return}
        let sectionName = section.rawValue
        header.dispalySectionTitle(text: sectionName)
    }
    
    func configure<T>(cell: T, at section: Int, for indexPath: Int) {
        let sectionType =  sectionsHandler!.typeForIndex(index: section)

        switch sectionType {
            case .Podcasts:
                let podcast = favoritePodcasts[indexPath]
                configurePodcastCell(cell: cell as! FavoritePodcastCellView, cellData: podcast)
           
            case .Episodes:
                let episode = favoriteEpisodes[indexPath]
                configureEpisodeCell(cell: cell as! FavoriteEpisodeCellView, cellData: episode)
        }
    }
    
    private func configurePodcastCell(cell: FavoritePodcastCellView, cellData: LovedPodcastModel){
        
        if let imageURL = URL(string: cellData.image ?? ""){
            cell.displayPodcastImage(imageURL: imageURL)
        }
        
        cell.displayPodcastTitle(title: cellData.title)
    }
    
    private func configureEpisodeCell(cell: FavoriteEpisodeCellView, cellData: LovedEpisode){
       
        if let imageURL = URL(string: cellData.image ?? ""){
            cell.displayEpisodeImage(with: imageURL)
        }
        
        cell.displayEpisodeTitle(title: cellData.title)
        cell.displayEpisodePublisher(publisher: cellData.publisher)
        
        let duration = cellData.audio_length_sec / 60
        let durationString =  String(format: "%02d", duration) + "min"
        cell.displayDuraion(duration: durationString)
    }
}

//MARK:- cell selected 
extension FavoritesPresenter{
    
    func cellSelected(at section: Int, for indexPath: Int) {
       
        guard let section = sectionsHandler?.typeForIndex(index: section) else {return}

        switch section {
            case .Podcasts:
                let selectedObject = favoritePodcasts[indexPath]
                let convertObject = convert(from: LovedPodcastModel.self, object: selectedObject, conversionType: PodcastObject.self)
                router?.moveToPodcastDetails(with: convertObject)
                
            case .Episodes:
                let selectedObject = favoriteEpisodes[indexPath]
                let convertEpisode = convert(from: LovedEpisode.self, object: selectedObject, conversionType: EpisodeObject.self)
                router?.moveToAudioPlayer(with: convertEpisode)
        }
    }
    
    func convert<T,C>(from type: T.Type, object: T, conversionType: C.Type) -> C {
        
        if type == LovedPodcastModel.self{
            return convertPodcast(object: object as! LovedPodcastModel) as! C
        }
        else{
            let episode = object as! LovedEpisode
            let episodePodcast = convertPodcast(object: episode.podcast!)

            let convertedObject = EpisodeObject(id: episode.id, title: episode.title, audio: episode.audioLink!, description: episode.description, image: episode.image, audio_length: episode.audio_length_sec, podcast: episodePodcast)
            
            return convertedObject as! C
        }
    }
    
    func convertPodcast(object: LovedPodcastModel) -> PodcastObject{
        
        let podcast = object
        let convertedObject = PodcastObject(
            id: podcast.id, title: podcast.title,
            publisher: podcast.publisher, image: podcast.image,
            description: podcast.info, total_episodes: podcast.total_episodes,
            genre_ids: podcast.genre_ids.toArray(type: Int.self),
            listennotes_url: podcast.listennotes_url
        )
        return convertedObject
    }
}


extension FavoritesPresenter: FavoritesInteractorOutput{
    
    func success(with episodes: [LovedEpisode]) {
        defer {
            fetchGroup.leave()
        }
        self.favoriteEpisodes = episodes
        sectionsHandler?.append(section: "Episodes")
    }
    
    func success(with podcasts: [LovedPodcastModel]) {
        defer {
            fetchGroup.leave()
        }
        
        self.favoritePodcasts = podcasts
        sectionsHandler?.append(section: "Podcasts")
    }
    
    func failed(with error: String) {
        defer {
            fetchGroup.leave()
        }
        
        print(error)
    }
    
}


extension FavoritesPresenter: PlayerViewDelegate {
    func playerViewWillDisappear() {
        viewWillAppear()
    }
}
