//
//  FollowersListViewModel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import Foundation

public protocol FollowersFlowDelegate:AnyObject{
    func getFollowersSuccessful(followersList:[FollowerModel])
    func getFollowersFailed(errorMessage:String)
    func addFavouriteSuccessul()
    func addFavouriteFailed(errorMessage:String)
}

public class FollowersListViewModel {
    
   // public var followersList : [FollowerModel]
    public var pageNumber:Int
    public var followersDelegate:FollowersFlowDelegate?
    public var userName:String
    
    private var hasMoreFollowers: Bool = true
    public var appendedFollowersList: [FollowerModel]
    
    //The delegate which will perform action based on viewmodel delegates will be passed
    init(delegate:FollowersFlowDelegate?,userName:String) {
        self.followersDelegate = delegate
        self.appendedFollowersList = []
        self.pageNumber = 1
        self.userName = userName
    }
    
    func getFollowers(){
        //Validation to chcek if user has more followers before making API call
        guard hasMoreFollowers else {
            self.followersDelegate?.getFollowersFailed(errorMessage: ErrorMessages.userHasNoMoreFollowers.rawValue)
            return
        }
        //API call to get the followers for the username
        NetworkManager.sharedInstance.getFollowers(for: self.userName, in: self.pageNumber) { (result) in
            switch result{
                case .success(let followersListFromResponse):
                    if followersListFromResponse.isEmpty{
                        self.hasMoreFollowers = false
                    }
                    self.getTheAppendedListOfFollowers(newListOfFollowers: followersListFromResponse)
                    if self.appendedFollowersList.isEmpty{
                        self.followersDelegate?.getFollowersFailed(errorMessage: ErrorMessages.userHasNoFollowers.rawValue)
                    }else{
                        self.followersDelegate?.getFollowersSuccessful(followersList: self.appendedFollowersList)
                    }
                case .failure(let errorMessage):
                    self.followersDelegate?.getFollowersFailed(errorMessage: errorMessage.rawValue)
            }
        }
    }
    
    func addCurrentUserAsFavourite(){
        NetworkManager.sharedInstance.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                let favorite = FollowerModel.init(login: user.login, avatar_url: user.avatar_url)
                
                PersistenceManager.updateWith(follower: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.followersDelegate?.addFavouriteSuccessul()
                        return
                    }
                    self.followersDelegate?.addFavouriteFailed(errorMessage: error.rawValue)
                }
            case .failure(let error):
                self.followersDelegate?.addFavouriteFailed(errorMessage: error.rawValue)
            }
        }
    }
    
    
    //Append the list of followers recevid after updating the pagination value
    func getTheAppendedListOfFollowers(newListOfFollowers:[FollowerModel]){
        self.appendedFollowersList.append(contentsOf: newListOfFollowers)
    }
    
    func getFilteredFollowersList(filter:String) -> [FollowerModel] {
        let filteredFollowers = self.appendedFollowersList.filter { $0.login.lowercased().contains(filter.lowercased()) }
        return filteredFollowers
    }
}
