//
//  HomeVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

extension HomeVC: HomeView{
    
    func reloadHomeCollectionView() {
        print("reloaded")
        DispatchQueue.main.async {
            self.homeCollectionView?.reloadData()
        }
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
        var cell: UICollectionViewCell
        
        switch indexPath.section{
        
        case 0:
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCell.identifier, for: indexPath) as! RecentlyPlayedCell
            presenter?.configureCell(at: indexPath.section, for: indexPath.row, cell: cell)
            return cell
        
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastCell.identifier, for: indexPath) as! PodcastCell
            presenter?.configureCell(at: indexPath.section, for: indexPath.row, cell: cell)
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = homeCollectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionsCollectionReusableView.identifier, for: indexPath) as! HomeSectionsCollectionReusableView
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
