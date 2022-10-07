//
//  PodcastDetailsVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import UIKit
import SDWebImage


extension PodcastDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tableViewCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PodcastDetailsEpisodesTableViewCell.identifier, for: indexPath) as! PodcastDetailsEpisodesTableViewCell
        presenter?.configureCell(at: indexPath.row, for: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 5, y: 0, width: view.frame.width - 10, height: 35)
        let view = PodcastDetailsTableSectionHeader(frame: frame)
        view.backgroundColor = .white
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectCell(at: indexPath.row)
    }
}

extension PodcastDetailsVC: PodcastDetailsView {
 
    func showLoader() {
        self.showIndicator()
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.hideIndicator()
        }
    }
    
    func reloadEpisodesTableView() {
        
        DispatchQueue.main.async {
            self.episodesTableView.reloadData()
        }
    }
    
    func updateOutletHeight(outlet: UIView){
        let oldheight = outlet.frame.height
        outlet.sizeToFit()

        if oldheight > outlet.frame.height{
           topViewHeightConstraint.constant = topViewHeightConstraint.constant - abs(outlet.frame.height - oldheight)
        }
        else{
            topViewHeightConstraint.constant = topViewHeightConstraint.constant + abs(outlet.frame.height - oldheight)
        }
        topView.layoutIfNeeded()
    }
    
    func updateScrollViewHeight() {
        
        let newSize = topView.frame.height
        let window = UIApplication.shared.windows.first
        let viewHeight = view.frame.height - ((window?.safeAreaInsets.top)! + (window?.safeAreaInsets.bottom)!)

    
        if newSize > viewHeight {
            let addtionalHeight = newSize - viewHeight
            scrollViewHeightConstraint.constant =  addtionalHeight + (viewHeight * 2)
        }
        else{
            scrollViewHeightConstraint.constant = (viewHeight + newSize) - 50 - (self.navigationController?.navigationBar.frame.height)!
        }
        
        scrollView.layoutIfNeeded()
    }
    
    func displayPodcastPoster(with url: URL?) {
        podcastPosterImageView.sd_setImage(with: url)
    }
    
    func displayPodcastTitle(title: String) {
        podcastTitleLabel.text = title
        podcastTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func displayPodcastPublisher(publisher: String) {
        publisherNameLabel.text = publisher
        updateOutletHeight(outlet: publisherNameLabel)
    }
    
    func displayPodcastDescription(description: String) {
        descriptionTextView.text = description
        updateOutletHeight(outlet: descriptionTextView)
    }
    
    func displayEpisodeNumber(number: String) {
        episodesNumberLabel.text = number
        updateOutletHeight(outlet: episodesNumberLabel)
    }
    
    func showErrorAlert(title: String, message: String, actionTitle: String, actionHandler: @escaping ((UIAlertAction)?) -> ()) {
        self.showAlertWithOk(alertTitle: title, message: message, actionTitle: actionTitle, actionHandler: actionHandler)
    }
    
    func updateLovedImage(with named: String) {
        loveButton.setImage(UIImage(systemName: named), for: .normal)
    }
    
    func updateSelectedLovedTint(){
        loveButton.tintColor = .systemRed
    }
    
    func updateNormalLovedTint(){
        loveButton.tintColor = .lightGray
    }

}


