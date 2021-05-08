//
//  FollowersListVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import UIKit

protocol FollowerListVCDelegate : class {
    func didRequestFollowers(for userName:String)
}

class FollowersListVC: UIViewController {
    @IBOutlet weak var followersListCollectionView: UICollectionView!
    
    public var followersListVM:FollowersListViewModel?
    public var pageTitle:String?
    var filteredFollowers : [FollowerModel] = []
    var isSearching = false
    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!

    enum Section{
        case main
    }
    
    var collectionViewDiffableDataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.followersListCollectionView.delegate = self
        self.followersListCollectionView.register(UINib.init(nibName: "FollowerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)

        self.configureDiffableDataSourceForCollectionView()
        //To load data using diffable data source
        self.getTheFollowersForUserName()
        
        //Configure the search controller
        self.configureSearchController()

        self.configureDataSource()
        
        self.addFavButtonInNavbar()
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Followers Here"
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    func getTheFollowersForUserName(){
        self.displayLoadingView()
        self.followersListVM?.getFollowers()
    }
    
    func addFavButtonInNavbar(){
        let addFavButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addFavButtonTapped))
        self.navigationItem.rightBarButtonItem = addFavButton
    }
    
    @objc func addFavButtonTapped(){
        self.followersListVM?.addCurrentUserAsFavourite()
    }
}

//Extension to implement the seach controller delegate methods
extension FollowersListVC:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else { return }
        self.isSearching = true
        filteredFollowers = self.followersListVM?.appendedFollowersList.filter{$0.login.lowercased().contains(filter.lowercased())} ?? []
        self.updateData(with: self.filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.updateData(with: self.followersListVM?.appendedFollowersList ?? [])
        self.isSearching = false
    }
    
    func updateData(with followers:[FollowerModel]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,FollowerModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        collectionViewDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

//Extension to implement the view model delegate methods
extension FollowersListVC:FollowersFlowDelegate{
    func addFavouriteSuccessul() {
        self.displayAlertPopup(alertTitle: AppMessages.successString, alertMessage: AppMessages.addFavouriteSuccessful, buttonTitle: AppMessages.okString)
    }
    
    func addFavouriteFailed(errorMessage: String) {
        self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: errorMessage, buttonTitle: AppMessages.okString)
    }
    
    func getFollowersSuccessful(followersList: [FollowerModel]) {
        self.dismissLoadingView()
        DispatchQueue.main.async {
            self.updateData(with: followersList)
        }
    }
    
    func getFollowersFailed(errorMessage: String) {
        self.dismissLoadingView()
        self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: errorMessage, buttonTitle: AppMessages.okString)
    }
}


//Extension to set up the collection view items , cell and size of cells
extension FollowersListVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func configureDataSource(){
        self.collectionViewDataSource = UICollectionViewDiffableDataSource.init(collectionView: self.followersListCollectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = self.followersListCollectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as? FollowerCollectionViewCell
            cell?.setFollowerDetails(follower: follower)
            return cell
        })
    }
    
    
    //Configuration of the diffable data source for the collection view
    func configureDiffableDataSourceForCollectionView(){
        collectionViewDiffableDataSource = UICollectionViewDiffableDataSource.init(collectionView: self.followersListCollectionView, cellProvider: { (collectionView, indexpath, follower) -> UICollectionViewCell? in
            let cell = self.followersListCollectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexpath) as? FollowerCollectionViewCell
            cell?.setFollowerDetails(follower: follower)
            return cell
        })
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthOfCells:CGFloat = (self.followersListCollectionView.bounds.width-50)/3
        let heightOfCells:CGFloat = 120
        return CGSize.init(width: widthOfCells, height: heightOfCells)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //Logic for pagination
    //Need three value -> Content offset , content height , height of collection view
    //Content offset tells us how much scrolling has been done form the start point
    //Content height tells us the height of the total content diesplayed
    //Height is the height of the UI component
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contenHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        //Will check if the y value afer scrolling is greater than the content size of the elements in the collection view
        if offSetY > (contenHeight - height){
            self.followersListVM?.pageNumber += 1
            self.displayLoadingView()
            self.followersListVM?.getFollowers()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? self.filteredFollowers : self.followersListVM?.appendedFollowersList
        let follower = activeArray?[indexPath.row]
        
        let destinationVC = UserInfoVC.init()
        destinationVC.delegate = self
        destinationVC.getUserInfoVM = GetUserInfoViewModel.init(userInfoDelegate: destinationVC, userName: follower?.login ?? String.empty)
        destinationVC.userName = follower?.login ?? String.empty
        let navController = UINavigationController.init(rootViewController: destinationVC)
        self.present(navController, animated: true, completion: nil)
    }
}


extension FollowersListVC:FollowerListVCDelegate{
    func didRequestFollowers(for userName: String) {
        //Get followers
        self.followersListVM?.userName = userName
        self.followersListVM?.pageNumber = 1
        self.title = userName
        self.followersListVM?.appendedFollowersList.removeAll()
        self.followersListCollectionView.setContentOffset(.zero, animated: true)
        self.displayLoadingView()
        self.followersListVM?.getFollowers()
    }
}
