//
//  ErrorMessages.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import Foundation

enum ErrorMessages : String , Error {
    case invalidUsername = "This username created invalid request . Please try again"
    case unableToCompleteRequest = "Unable to complete request. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from server is invalid."
    case unableToAddFavourite = "Unable to add  username to favourites."
    case alreadyInFavourite = "Username already added as favourite"
    case enterValidUsername = "Please enter a valid username"
    case errorString = "Error"
    case unableToFetchFavourite = "Error trying to fetch favourite . Please try again ."
    case noFavAdded = "No Favourites Added"
    case userHasNoMoreFollowers = "User has no more followers"
    case userProfileURLInvalid = "User profile URL invalid"
    case userHasNoFollowers = "User does not have any followers"
}
