//
//  UserFollowerItemVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class UserFollowerItemVC: UserInfoItemVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(userInfoType: .followers, with: self.user.followers)
        itemInfoViewTwo.set(userInfoType: .following, with: self.user.following)
        actionButton.set(backgroundColour: .black, title: AppMessages.getFollowers)
    }
    
    override func actionButtonTapped() {
        self.delegate.didTapGetFollowers(for: self.user)
    }
}
