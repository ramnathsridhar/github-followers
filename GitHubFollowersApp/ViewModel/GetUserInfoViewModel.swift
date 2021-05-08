//
//  GetUserInfoViewModel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import Foundation

//Protocol methods to communicate with the corresponding view controller
public protocol GetUserInfoFlowDelegate:AnyObject{
    func getUserInfoSuccessful(userInfo:UserModel)
    func getUserInfoFailed(errorMessage:String)
}

class GetUserInfoViewModel{
    public var userInfoDelegate:GetUserInfoFlowDelegate?
    public var userName:String
    
    init(userInfoDelegate:GetUserInfoFlowDelegate?,userName:String) {
        self.userInfoDelegate = userInfoDelegate
        self.userName = userName
    }

    func getGetUserInfo(){
        NetworkManager.sharedInstance.getUserInfo(for: self.userName) { (result) in
            switch result{
            case .failure(let errorMessage):
                self.userInfoDelegate?.getUserInfoFailed(errorMessage: errorMessage.rawValue)
            case .success(let userInfo):
                self.userInfoDelegate?.getUserInfoSuccessful(userInfo: userInfo)
            }
        }
    }
}
