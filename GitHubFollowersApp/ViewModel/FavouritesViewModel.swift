//
//  FavouritesViewModel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import Foundation

//Protocol methods to communicate with the corresponding view controller
protocol FavouritesDelegate:AnyObject{
    func getFavouritesSuccessful()
    func noFavouritesAdded()
    func getFavouritesFailed(errorMessage:String)
    func deleteFavouriteFailed(errorMessage:String)
    func deleteFavouriteSuccessful(indexDeleted:IndexPath)
}

class FavouritesViewModel{
    var favouriteList : [FollowerModel]
    var favouritesDelegate:FavouritesDelegate?
        
    init(favouritesDelegate:FavouritesDelegate?,favouriteList:[FollowerModel] = []) {
        self.favouritesDelegate = favouritesDelegate
        self.favouriteList = favouriteList
    }
    
    //Function to get the favourites saved by user from userdefaults
    func getFavourites(){
        //First the favourites added is retrieved
            PersistenceManager.retrieveFavourites { [weak self] (result) in
                switch result {
                case .success(let favouritesList):
                    self?.favouriteList = favouritesList
                    if self?.favouriteList.isEmpty ?? true{
                        self?.favouritesDelegate?.noFavouritesAdded()
                    }else{
                        self?.favouritesDelegate?.getFavouritesSuccessful()
                    }
                case .failure(let errorMessage):
                    self?.favouritesDelegate?.getFavouritesFailed(errorMessage: errorMessage.rawValue)
                }
            }
    }
    
    //Function to delete the favourite selected by user
    func deleteFavourite(indexOfFavourite:IndexPath){
        let selectedFavourite = favouriteList[indexOfFavourite.row]
        self.favouriteList.remove(at: indexOfFavourite.row)
        
        PersistenceManager.updateWith(follower: selectedFavourite, actionType: .remove) { [weak self] (error) in
            if let errorMessage = error {
                self?.favouritesDelegate?.deleteFavouriteFailed(errorMessage: errorMessage.rawValue)
                return
            }else{
                if self?.favouriteList.isEmpty ?? true{
                    self?.favouritesDelegate?.noFavouritesAdded()
                }else{
                    self?.favouritesDelegate?.deleteFavouriteSuccessful(indexDeleted:indexOfFavourite)
                }
            }
        }
    }
}
