//
//  HomeVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

extension HomeVC: HomeView{


    
    
}


extension HomeVC: UICollectionViewDataSource , UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        switch indexPath.section{
        
        case 0:
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCell.identifier, for: indexPath) as! RecentlyPlayedCell
            return cell
        
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastCell.identifier, for: indexPath) as! PodcastCell
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = homeCollectionView?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionsCollectionReusableView.identifier, for: indexPath) as! HomeSectionsCollectionReusableView
        presenter?.titleForSection(for: indexPath.section, header: header)
        return header
    }
}
