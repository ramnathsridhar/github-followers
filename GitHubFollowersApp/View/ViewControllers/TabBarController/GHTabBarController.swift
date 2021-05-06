//
//  GHTabBarController.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import UIKit

class GHTabBarController : UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [createSearchNavigationController(),createFavouritesNavigationController()]
    }
    
    //Creating the search user VC to add it in the tab bar
     func createSearchNavigationController() -> UINavigationController{
         let userNameVC = UserNameVC()
         userNameVC.title = AppMessages.searchUsername
         //Setting the icon in the tab bar to the default search icon
         userNameVC.tabBarItem = UITabBarItem.init(tabBarSystemItem: .search, tag: 0)
         userNameVC.tabBarItem.accessibilityIdentifier = AccessibilityIdentifers.searchTabBarButton
         return UINavigationController(rootViewController: userNameVC)
     }
     
     //Creating the favourites VC to add it in the tab bar
     func createFavouritesNavigationController() -> UINavigationController{
         let favouritesVC = FavouritesVC()
         favouritesVC.title = AppMessages.favourites
         //Setting the icon in the tab bar to the default favourite icon
         favouritesVC.tabBarItem = UITabBarItem.init(tabBarSystemItem: .favorites, tag: 1)
         favouritesVC.tabBarItem.accessibilityIdentifier = AccessibilityIdentifers.favouriteTabBarButton
         return UINavigationController(rootViewController: favouritesVC)
     }
    
    
}
