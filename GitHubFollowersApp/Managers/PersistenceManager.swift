//
//  PersistenceManager.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import Foundation

enum PersistenceActionType{
    case add , remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    
    enum Keys{
        static let favourites = "favourites"
    }
    
    static func updateWith(follower:FollowerModel,actionType:PersistenceActionType,completed: @escaping (ErrorMessages?) -> Void){
        retrieveFavourites { (result) in
            switch result{
            case .failure(let error):
                completed(error)
            case .success(let followers):
                var retrievedFavourites = followers
                //Switch statements to perform the action specified in the argument
                switch actionType {
                case .add:
                    //Check of the object already exists before adding it
                    guard !retrievedFavourites.contains(follower) else {
                        completed(ErrorMessages.alreadyInFavourite)
                        return
                    }
                    //Add the follower object in retrieved favourties list
                    retrievedFavourites.append(follower)
                case .remove:
                    //Remove the occurance of the follower object in retrieved favourties list
                    retrievedFavourites.removeAll { $0.login == follower.login}
                }
                //Save the modified favourtie list into user defaults
                completed(saveFavourites(followers: retrievedFavourites))
                return
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping (Result<[FollowerModel],ErrorMessages>) -> Void){
        //Custom objects require encoding and decoding
        guard let favoritesData = defaults.object(forKey: Keys.favourites) as? Data else{
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder.init()
            let followers = try decoder.decode([FollowerModel].self, from: favoritesData)
            completed(.success(followers))
        } catch  {
            completed(.failure(ErrorMessages.unableToAddFavourite))
        }
    }
    
    static func saveFavourites(followers: [FollowerModel]) -> ErrorMessages?{
        do {
            let encoder = JSONEncoder.init()
            let encodedFavourites = try encoder.encode(followers)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
        } catch  {
            return ErrorMessages.unableToAddFavourite
        }
        return nil
    }
}
