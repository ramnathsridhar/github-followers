//
//  SearchUserNameViewModel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import Foundation

//Protocol methods to communicate with the corresponding view controller
public protocol SearchUserNameFlowDelegate:AnyObject{
    func getUserNameFollowersSuccessful()
    func getUserNameFollowersFailed(errorMessage:String)
}

class SearchUserNameViewModel{
    public var userNameDelegate:SearchUserNameFlowDelegate?
    public var enteredUsername:String
    
    //The delegate which will perform action based on the delegate
    init(delegate:SearchUserNameFlowDelegate?) {
        self.userNameDelegate = delegate
        self.enteredUsername = String.empty
    }
    
    //Function to check if the username entered is valid before proceeding to the next page
    func getFollowersForUser(){
        if validateUserName(){
            self.userNameDelegate?.getUserNameFollowersSuccessful()
        }else{
            self.userNameDelegate?.getUserNameFollowersFailed(errorMessage: ErrorMessages.enterValidUsername.rawValue)
        }
    }
    
    //Validations to be done on the entered username
    //Will return true if the username is not empty
    func validateUserName() -> Bool{
        return !self.enteredUsername.isEmpty
    }
}
