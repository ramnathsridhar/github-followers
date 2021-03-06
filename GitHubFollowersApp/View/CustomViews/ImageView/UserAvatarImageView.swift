//
//  UserAvatarImageView.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class UserAvatarImageView: UIImageView {
    //The default image used
    let placeHoldermage = UIImage(named: ImageConstants.placeHolderImage)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.configure()
    }
    
    private func configure(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.image = placeHoldermage
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
