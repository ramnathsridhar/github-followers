//
//  FollowersListViewModel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import Foundation

//Protocol methods to communicate with the corresponding view controller
public protocol FollowersFlowDelegate:AnyObject{
    func getFollowersSuccessful(followersList:[FollowerModel])
    func getFollowersFailed(errorMessage:String)
    func addFavouriteSuccessul()
    func addFavouriteFailed(errorMessage:String)
}

public class FollowersListViewModel {
    
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
                        //The flag is set to false so that if API call is not made again if there are no more followers
                        self.hasMoreFollowers = false
                    }
                    self.getTheAppendedListOfFollowers(newListOfFollowers: followersListFromResponse)
                    //Check to see if the user has any followers
                    if self.appendedFollowersList.isEmpty{
                        self.followersDelegate?.getFollowersFailed(errorMessage: ErrorMessages.userHasNoFollowers.rawValue)
                    }else{
                        //If user has followers , then pass the array to the VC for display
                        self.followersDelegate?.getFollowersSuccessful(followersList: self.appendedFollowersList)
                    }
                case .failure(let errorMessage):
                    self.followersDelegate?.getFollowersFailed(errorMessage: errorMessage.rawValue)
            }
        }
    }
    
    //API call to get the userinformation of a user , given the username and then save the user as a favourite user
    func addCurrentUserAsFavourite(){
        NetworkManager.sharedInstance.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                //If the user information is recevied successfully , then save the user as a favourtie
                //The user login string and the user avatar url are saved
                let favorite = FollowerModel.init(login: user.login, avatar_url: user.avatar_url)
                
                PersistenceManager.updateWith(follower: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    //If the error is nil , then the add favourite is successfull
                    guard let error = error else {
                        self.followersDelegate?.addFavouriteSuccessul()
                        return
                    }
                    //If the error is not nil , then the add favourite has failed
                    self.followersDelegate?.addFavouriteFailed(errorMessage: error.rawValue)
                }
            case .failure(let error):
                self.followersDelegate?.addFavouriteFailed(errorMessage: error.rawValue)
            }
        }
    }
    
    //Append the list of followers received after updating the pagination value
    func getTheAppendedListOfFollowers(newListOfFollowers:[FollowerModel]){
        self.appendedFollowersList.append(contentsOf: newListOfFollowers)
    }
    
    //Function to get the filtered lsit of followers using the string entered in the search bar as the filter
    func getFilteredFollowersList(filter:String) -> [FollowerModel] {
        let filteredFollowers = self.appendedFollowersList.filter { $0.login.lowercased().contains(filter.lowercased()) }
        return filteredFollowers
    }
}
