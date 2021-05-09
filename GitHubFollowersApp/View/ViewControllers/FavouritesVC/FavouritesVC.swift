//
//  FavouritesVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import UIKit

class FavouritesVC: UIViewController {

    @IBOutlet weak var favouritesListTableView: UITableView!
    @IBOutlet weak var noFavouritesAddedLabel: TitleLabel!
    
    var favouritesViewModel : FavouritesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.favouritesListTableView.delegate = self
        self.favouritesListTableView.dataSource = self
        self.favouritesListTableView.register(UINib.init(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: FavouriteTableViewCell.reuseID)
        self.favouritesListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favouritesViewModel?.getFavourites()
    }
}

extension FavouritesVC:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favouritesViewModel?.favouriteList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.favouritesListTableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.reuseID) as? FavouriteTableViewCell
        cell?.setUserDetails(userName:  self.favouritesViewModel?.favouriteList[indexPath.row].login ?? String.empty, userImageURL: self.favouritesViewModel?.favouriteList[indexPath.row].avatar_url ?? String.empty)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let followersListVC = FollowersListVC.init()
        followersListVC.title = self.favouritesViewModel?.favouriteList[indexPath.row].login ?? String.empty
        followersListVC.followersListVM = FollowersListViewModel.init(delegate: followersListVC, userName: self.favouritesViewModel?.favouriteList[indexPath.row].login ?? String.empty)
        self.navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Perform action only if the editing style is delete
        guard editingStyle == .delete else { return }
        self.favouritesViewModel?.deleteFavourite(indexOfFavourite: indexPath)
    }
}

extension FavouritesVC : FavouritesDelegate{
    func getFavouritesSuccessful() {
        self.favouritesListTableView.isHidden = false
        self.noFavouritesAddedLabel.isHidden = true
        self.favouritesListTableView.bringSubviewToFront(self.view ?? UIView())
        self.favouritesListTableView.reloadData()
    }
    
    func deleteFavouriteSuccessful(indexDeleted: IndexPath) {
        self.favouritesListTableView.deleteRows(at: [indexDeleted], with: .fade)
    }
    
    func deleteFavouriteFailed(errorMessage: String) {
        self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: errorMessage , buttonTitle: AppMessages.okString)
    }
    
    func noFavouritesAdded() {
        self.noFavouritesAddedLabel.isHidden = false
        self.favouritesListTableView.isHidden = true
        self.noFavouritesAddedLabel.bringSubviewToFront(self.view ?? UIView())
    }
    
    func getFavouritesFailed(errorMessage: String) {
        self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: errorMessage, buttonTitle: AppMessages.okString)
    }
}
