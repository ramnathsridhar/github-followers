//
//  UserAvatarImageView.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class UserAvatarImageView: UIImageView {
    
    let cache = NetworkManager.sharedInstance.cache
    let placeHoldermage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.image = placeHoldermage
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
