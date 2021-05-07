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
}

public class FollowersListViewModel {
    
    public var followersList : [FollowerModel]
    public var pageNumber:Int
    public var followersDelegate:FollowersFlowDelegate?
    public var userName:String
    
    private var hasMoreFollowers: Bool = true
    public var appendedFollowersList: [FollowerModel]
    
    //The delegate which will perform action based on viewmodel delegates will be passed
    init(delegate:FollowersFlowDelegate,userName:String) {
        self.followersDelegate = delegate
        self.followersList = []
        self.appendedFollowersList = self.followersList
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
                        return
                    }
                    self.followersDelegate?.getFollowersSuccessful(followersList: self.getTheAppendedListOfFollowers(newListOfFollowers: followersListFromResponse))
                case .failure(let errorMessage):
                    self.followersDelegate?.getFollowersFailed(errorMessage: errorMessage.rawValue)
            }
        }
    }
    
    //Append the list of followers recevid after updating the pagination value
    func getTheAppendedListOfFollowers(newListOfFollowers:[FollowerModel]) -> [FollowerModel]{
        self.appendedFollowersList.append(contentsOf: newListOfFollowers)
        return appendedFollowersList
    }
}
