//
//  FavoritesVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit
import Lottie

class FavoritesVC: UIViewController {
    
    var presenter: FavoritesViewPresenter?
    var favoritesCollectionView: UICollectionView?
    var sectionsLayout = [NSCollectionLayoutSection]()
    
    
    internal var noFavoritesAnimationView: UIView!
    internal var noFavoritesLabel: UILabel!
    internal var noFavoritesAnimation: AnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.viewWillAppear()
        setupNavigationBarAppearance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFavoritesCollectionView()
        createAnimationContainer()
        createNoFavoriteLabel()
    }
    
    private func setupNavigationBarAppearance(){
     
         let color = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
         let appearance = UINavigationBarAppearance()
         let attributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
         
         appearance.titleTextAttributes = attributes
         appearance.largeTitleTextAttributes = attributes
         navigationItem.title = "Favorites"
         navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func configureFavoritesCollectionView(){
        
        favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        favoritesCollectionView?.backgroundColor = .clear
        
        favoritesCollectionView?.register(
            UINib(nibName: FavoriteEpisodeCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: FavoriteEpisodeCollectionViewCell.identifier
        )
        
        favoritesCollectionView?.register(
            UINib(nibName: FavoritePodcastCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: FavoritePodcastCollectionViewCell.identifier
        )
        
        favoritesCollectionView?.register(SectionsCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionsCollectionReusableView.identifier
        )
        
        favoritesCollectionView?.delegate = self
        favoritesCollectionView?.dataSource = self
        
        favoritesCollectionView?.frame = CGRect(x: 10, y: view.safeAreaInsets.top
                                                , width: view.frame.size.width - 20, height: view.frame.height)
        view.addSubview(favoritesCollectionView!)
    }
    

}

//MARK:- Collection view layout and sections
extension FavoritesVC{
    
    internal func configureCollectionViewSectionLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex, _)  -> NSCollectionLayoutSection? in
            return self?.sectionsLayout[sectionIndex]
        }
        
        return layout
    }
    
    internal func createFavoritePodcastSectionLayout() -> NSCollectionLayoutSection{
        
        let sectionHeader = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(230))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = sectionHeader
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    internal func createFavoriteEpisodeSectionLayout() -> NSCollectionLayoutSection{
        
        let sectionHeader = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98),
                                                   heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = sectionHeader
        return section
    }
}
