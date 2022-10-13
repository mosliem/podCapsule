//
//  HomeVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

extension HomeVC: HomeView{
    
    func showLoader() {
        self.showIndicator()
    }
    
    func hideLoader() {
        self.hideIndicator()
    }
    
    func addRecentlyPlayedSection() {
        homeSectionsLayout.insert(createRecentlyPlayedSection(), at: 0)
    }
    
    func addPodcastSection() {
        homeSectionsLayout.append(createPodcastsSection())
    }
    
    func assignCollectionViewLayout(){
        homeCollectionView?.collectionViewLayout = self.createLayout()
    }
    
    func reloadHomeCollectionView() {
        self.homeCollectionView?.reloadData()
    }
    
}


extension HomeVC: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter?.itemsForSection(for: section))!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue((presenter?.cellType(for: indexPath.section))!, for: indexPath)
        presenter?.configureCell(at: indexPath.section, for: indexPath.row, cell: cell)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = homeCollectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionsCollectionReusableView.identifier, for: indexPath) as! SectionsCollectionReusableView
        presenter?.titleForSection(for: indexPath.section, header: header)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        let row = indexPath.row
        let section = indexPath.section
        
        presenter?.cellSelected(at: section, row: row)
        
    }

}
