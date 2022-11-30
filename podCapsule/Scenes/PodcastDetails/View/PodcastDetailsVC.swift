//
//  PodcastDetailsVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import UIKit

class PodcastDetailsVC: UIViewController {
    
    var presenter: PodcastDetailsViewPresenter?
    
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var podcastTitleLabel: UILabel!
    
    @IBOutlet weak var podcastPosterShadowView: UIView!
    @IBOutlet weak var podcastPosterImageView: UIImageView!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var episodesNumberLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var episodesTableView: UITableView!
    
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loveButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.largeTitleDisplayMode = .never
        setupNavigationBarAppearance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        renderView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance = nil
        navigationItem.largeTitleDisplayMode = .always
        presenter?.viewWillDisapear()
    }

    private func setupNavigationBarAppearance(){
        let color = #colorLiteral(red: 0.1890609975, green: 0.2222151391, blue: 0.2243165675, alpha: 1)
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithTransparentBackground()
        appearance.backgroundImage = UIImage()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .lightGray
        appearance.shadowColor?.withAlphaComponent(0.3)
        
        //Navigation Bar title
        self.navigationItem.title = "Podcast Details"
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color ,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Back button style and title
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ], for: .normal)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = color
        navigationController?.navigationItem.largeTitleDisplayMode = .never

    }
    
    private func renderView(){
        configurePosterShadow()
        roundPodcastPoster()
        configureTableView()
        configureScrollView()
    }
    
    private func configureScrollView(){
        detailsScrollView.delegate = self
    }
    
    private func configureTableView(){
        
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        
        episodesTableView.register(
            UINib(nibName: PodcastDetailsEpisodesTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: PodcastDetailsEpisodesTableViewCell.identifier
        )
        
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func roundPodcastPoster(){
        podcastPosterImageView.clipsToBounds = true
        podcastPosterImageView.layer.cornerRadius = 20
    }
    
    private func configurePosterShadow(){
        podcastPosterShadowView.layer.cornerRadius = 20
        podcastPosterShadowView.layer.shadowColor = UIColor.lightGray.cgColor
        podcastPosterShadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
        podcastPosterShadowView.layer.shadowRadius = 10
        podcastPosterShadowView.layer.shadowOpacity = 0.3
    }
    
    @IBAction func loveButtonPressed(_ sender: UIButton) {
        presenter?.lovePressed()
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        presenter?.sharePressed()
    }
}
