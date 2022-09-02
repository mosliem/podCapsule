//
//  HomeProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

protocol HomeView: class {
    
    var presenter: HomeViewPresenter? { get set }
    

}


protocol HomeViewPresenter {
    
    var view: HomeView? { get set }
    init(view: HomeView?)
    
    func viewDidAppear()
    
    func numberOfSections() -> Int
    func itemsForSection(for section: Int) -> Int
    func titleForSection(for section: Int, header: HomeCollectionReusableViewInput)
    
}


protocol HomeCollectionReusableViewInput: class  {
    
    func dispalySectionTitle(text: String)
}

protocol RecentlyPlayedCellView: class {
    
    func displayPosterImage(urlString: String?)
    func displayName(for episode: String)
    func displayRemainingTime(time: String)
    
}

protocol PodcastCellView: class {
    
    func displayPosterImage(urlString: String?)
    func displayName(for episode: String)

}
