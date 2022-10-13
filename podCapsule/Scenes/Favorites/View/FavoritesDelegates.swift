//
//  FavoritesDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.


import UIKit
import Lottie

extension FavoritesVC: FavoritesView{
    
    func resetCollectionViewLayout(){
        favoritesCollectionView?.collectionViewLayout = .init()
        sectionsLayout.removeAll()
    }
    
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
        sectionsLayout.append(createFavoritePodcastSectionLayout())
    }
    
    func appendEpisodeSectionLayout() {
        sectionsLayout.append(createFavoriteEpisodeSectionLayout())
    }
    
    func setCollectionSectionsLayout() {
        favoritesCollectionView?.collectionViewLayout = self.configureCollectionViewSectionLayout()
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
        let cell = collectionView.dequeue((presenter?.type(for: indexPath.section))!, for: indexPath)
        presenter?.configure(cell: cell, at: indexPath.section, for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter?.cellSelected(at: indexPath.section, for: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionView = favoritesCollectionView?.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionsCollectionReusableView.identifier, for: indexPath
        ) as! SectionsCollectionReusableView
        
        presenter?.titleForSection(at: indexPath.section, header: sectionView)
        return sectionView
    }
    
}

extension FavoritesVC{
    
    func createAnimationContainer(){
        let frame = CGRect(x: 25, y: view.safeAreaInsets.top + 100, width: view.frame.width - 50, height: (view.frame.height / 2) - 15)
        noFavoritesAnimationView = UIView(frame: frame)
        noFavoritesAnimationView.isHidden = true
        view.addSubview(noFavoritesAnimationView)
    }
    
    func createNoFavoriteLabel(){
        let frame = CGRect(x: 25, y: noFavoritesAnimationView.frame.height + 50, width: view.frame.width - 50, height: 30)
        noFavoritesLabel = UILabel(frame: frame)
        noFavoritesLabel.isHidden = true
        noFavoritesLabel.text = "No Favorites Yet!"
        noFavoritesLabel.textAlignment = .center
        noFavoritesLabel.textColor = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        noFavoritesLabel.font = UIFont(name: "Helvetica Neue Bold", size: 19)
        view.addSubview(noFavoritesLabel)
    }
    
    func showNoFavoritesFound() {

        noFavoritesAnimationView.isHidden = false
        noFavoritesAnimation?.isHidden = false
        noFavoritesLabel.isHidden = false
        
        noFavoritesAnimation = AnimationView(name: "emptyList")
        noFavoritesAnimation?.frame = CGRect(x: 0, y: 0, width: noFavoritesAnimationView.frame.width, height: noFavoritesAnimationView.frame.height)
        
        noFavoritesAnimation?.animationSpeed = 0.7
        noFavoritesAnimation?.loopMode = .loop
        noFavoritesAnimation?.play()
        noFavoritesAnimationView.addSubview(noFavoritesAnimation!)
    }
    
    func hideNoFavoritesFound() {
        noFavoritesAnimation?.pause()
        noFavoritesAnimation?.isHidden = true
        noFavoritesAnimationView.isHidden = true
        noFavoritesLabel.isHidden = true
    }
}
