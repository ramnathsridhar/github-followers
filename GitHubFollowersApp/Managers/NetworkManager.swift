//
//  NetworkManager.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import UIKit

public class NetworkManager {
    static let sharedInstance = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString,UIImage>()

    //API call to get the list of followers for a username
    //userName is the username for which followers will be retrieved
    //pageNumber is the value to be used in pagination calls
    //completed is the completion handler
    //It will return followers list as an array and on error will return the string
    func getFollowers(for userName:String,in pageNumber:Int,completed: @escaping(Result<[FollowerModel],ErrorMessages>) -> Void){
        
        let endpoint = baseURL + "\(userName)/followers?per_page=100&page=\(pageNumber)"
        //Check to see if the URL formed from the username is a valid URL
        guard let finalURL = URL(string: endpoint) else { return
            completed(.failure(ErrorMessages.invalidUsername))
        }
        //URLSession to make the API hit , passing the url
        let task = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            //First check to see if there is an error returned
            //Usually error is not nil when there is a internet connection issue
            if let _ = error{
                completed(.failure(ErrorMessages.unableToCompleteRequest))
            }
            //Second check to see the status code
            //200 status code is recevied when the http requst return successfully
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(ErrorMessages.invalidResponse))
                return
            }
            //Third check to see if data is received and not nil
            guard let data = data else{
                completed(.failure(ErrorMessages.invalidData))
                return
            }
            //Decoding the data received into an array of followers
            //Will throw an error if deocding is unsuccessfull
            do {
                let decoder = JSONDecoder.init()
                let followers = try decoder.decode([FollowerModel].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(ErrorMessages.invalidData))
            }
        }
        //Following is always called when making using an URLSession to start the API request
        task.resume()
    }
}
