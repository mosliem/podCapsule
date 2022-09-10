//
//  HomeVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

class HomeVC: UIViewController {
    
    var presenter: HomeViewPresenter?
    var homeCollectionView: UICollectionView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let color = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        let appearnce = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
        appearnce.titleTextAttributes = attributes
        appearnce.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.standardAppearance = appearnce
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        configureHomeCollectionView()
        presenter?.viewDidLoad()
    }
    
    
    private func configureHomeCollectionView(){
        
        homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        homeCollectionView?.register(UINib(nibName: PodcastCell.identifier, bundle: nil), forCellWithReuseIdentifier: PodcastCell.identifier)
        
        homeCollectionView?.register(UINib(nibName: RecentlyPlayedCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecentlyPlayedCell.identifier)
        
        homeCollectionView?.register(HomeSectionsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeSectionsCollectionReusableView.identifier)
        
        homeCollectionView?.delegate = self
        homeCollectionView?.dataSource = self
        
        homeCollectionView?.frame = CGRect(x: 10, y: 0, width: view.bounds.width , height: view.bounds.height)
        homeCollectionView?.backgroundColor = .clear
        view.addSubview(homeCollectionView!)
        
    }
    
    private  func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {  (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            switch sectionIndex{
            case 0:
                return self.createRecentlyPlayedSection()
            default:
                return self.createPodcastsSection()
            }
        }
        
        return layout
    }
    
}


//Creating Collection Sections
extension HomeVC{
    func createRecentlyPlayedSection() -> NSCollectionLayoutSection {
        
        let sectionHeaderHeight = CGFloat((presenter!.heightForRecentlyPlay()))
        
        let sectionHeader = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(sectionHeaderHeight)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(120))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0 , bottom: 4, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = sectionHeader
        return section
    }
    
    func createPodcastsSection() -> NSCollectionLayoutSection {
        
        let sectionHeader = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
            )
        ]
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(240))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = sectionHeader
        return section
    }
}
