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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
