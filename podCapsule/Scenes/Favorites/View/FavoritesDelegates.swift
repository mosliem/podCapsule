//
//  FavoritesDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

extension FavoritesVC: FavoritesView{
    
    func reloadFavoritesData() {
        DispatchQueue.main.async {
            self.favoritesCollectionView?.reloadData()
        }
    }
    
    func showLoader() {
        self.showIndicator()
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.hideIndicator()
        }
    }
    
    func appendPodcastSectionLayout() {
        sectionsLayout?.append(createFavoritePodcastSectionLayout())
    }
    
    func appendEpisodeSectionLayout() {
        sectionsLayout?.append(createFavoriteEpisodeSectionLayout())
    }
    
    func setCollectionSectionsLayout() {
        favoritesCollectionView?.collectionViewLayout = configureCollectionViewSectionLayout()
    }
    
    func showErrorAlert(title: String, message: String, actionTitle: String, actionHandler: @escaping (UIAlertAction?) -> ()) {
        self.showAlertWithOk(alertTitle: title, message: message, actionTitle: actionTitle, actionHandler: actionHandler)
    }
    
}

extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems(for: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = UICollectionViewCell()
        presenter?.configureCell(cell: cell , type: (presenter?.type(for: indexPath.section))!)
        return UICollectionViewCell()
    }
    
    
}
