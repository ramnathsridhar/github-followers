//
//  UIImageView+Ext.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import UIKit

extension UIImageView{
    //Func to download an image from the url
    //With saving to cache if required
    func downloadImage(from urlString:String){
        let cache = NetworkManager.sharedInstance.cache
        
        //Converting the url key into a nsstring
        let cacheKey = NSString.init(string: urlString)
        //Using the url as a key and checking if the vaue is present in cache
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //If let has to be used for checking if error is nil
            if error != nil {return}
                        
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{ return }
            
            guard let data = data else {return }
            
            guard let image = UIImage.init(data: data) else {return }
         
            //Setting the image in cache as a key value pair with the URL as key
            cache.setObject(image, forKey: cacheKey)
            
            //Always perform UI operation in the maon thread
            DispatchQueue.main.async {
                self.image = image
            }
        }
        //Always add task resume to make api call
        task.resume()
    }
}
