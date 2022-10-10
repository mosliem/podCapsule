//
//  FavoritesVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var presenter: FavoritesViewPresenter?
    internal var favoritesCollectionView: UICollectionView?
    internal var sectionsLayout: [NSCollectionLayoutSection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        configureFavoritesCollectionView()
    }
    
    private func configureFavoritesCollectionView(){
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        favoritesCollectionView = UICollectionView(frame: frame, collectionViewLayout: .init())
        
        favoritesCollectionView?.register(
            UINib(nibName: FavoriteEpisodeCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: FavoriteEpisodeCollectionViewCell.identifier
        )
        
        favoritesCollectionView?.register(
            UINib(nibName: FavoritePodcastCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: FavoritePodcastCollectionViewCell.identifier
        )
        
        favoritesCollectionView?.delegate = self
        favoritesCollectionView?.dataSource = self
        
        view.addSubview(favoritesCollectionView!)
    }
    
    internal func configureCollectionViewSectionLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _)  -> NSCollectionLayoutSection in
            return self.sectionsLayout![sectionIndex]
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
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = sectionHeader
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    internal func createFavoriteEpisodeSectionLayout() -> NSCollectionLayoutSection{
        let sectionHeader = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = sectionHeader
        return section
    }
}


