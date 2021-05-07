//
//  FollowersListVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import UIKit

class FollowersListVC: UIViewController {
    @IBOutlet weak var followersListCollectionView: UICollectionView!
    
    public var followersListVM:FollowersListViewModel?
    public var pageTitle:String?
    var filteredFollowers : [FollowerModel] = []
    
    enum Section{
        case main
    }
    
    var collectionViewDiffableDataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.followersListCollectionView.delegate = self
        self.followersListCollectionView.register(UINib.init(nibName: "FollowerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)

        self.configureDiffableDataSourceForCollectionView()
        //To load data using difafble data source
        self.getTheFollowersForUserName()
    }
    
    func getTheFollowersForUserName(){
        self.displayLoadingView()
        self.followersListVM?.getFollowers()
    }
}

//Extension to implement the view model delegate methods
extension FollowersListVC:FollowersFlowDelegate{
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
    //Configuration of the diffable data source for the collection view
    func configureDiffableDataSourceForCollectionView(){
        collectionViewDiffableDataSource = UICollectionViewDiffableDataSource.init(collectionView: self.followersListCollectionView, cellProvider: { (collectionView, indexpath, follower) -> UICollectionViewCell? in
            let cell = self.followersListCollectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexpath) as? FollowerCollectionViewCell
            cell?.setFollowerDetails(follower: follower)
            return cell
        })
    }
    
    //Updating the collection view to display updated followers list
    func updateData(with followers:[FollowerModel]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,FollowerModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        collectionViewDiffableDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
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
}
