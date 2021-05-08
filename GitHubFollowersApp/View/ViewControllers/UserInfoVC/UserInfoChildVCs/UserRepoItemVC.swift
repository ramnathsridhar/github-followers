//
//  UserRepoItemVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class UserRepoItemVC: UserInfoItemVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(userInfoType: .repos, with: self.user.public_repos)
        itemInfoViewTwo.set(userInfoType: .gists, with: self.user.public_gists)
        actionButton.set(backgroundColour: .black, title: AppMessages.gitProfile)
    }
    
    override func actionButtonTapped() {
        self.delegate.didTapGithubProfile(for: self.user)
    }
}
