//
//  UserInfoHeaderVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class UserInfoHeaderVC: UIViewController {
    
    let avatarImageView = UserAvatarImageView.init(frame: .zero)
    let userNameLabel = TitleLabel.init(textAlignment: .left, fontSize: 34)
    let nameLabel = SecondaryTitleLabel.init(sizeOfFont: 18)
    let locationImageView = UIImageView()
    let locationLabel = SecondaryTitleLabel.init(sizeOfFont: 18)
    let bioLabel = BodyLabel.init(textAlignment: .left)
    
    var user:UserModel!
    init(user:UserModel) {
        super.init(nibName:nil,bundle:nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layoutUI()
        self.configureUIElements()
    }
    
    func configureUIElements(){
        self.avatarImageView.downloadImage(from: user.avatar_url)
        self.userNameLabel.text = user.login
        self.nameLabel.text = user.name ?? String.empty
        self.locationLabel.text = user.location ?? AppMessages.noLocation
        self.bioLabel.text = user.bio ?? AppMessages.noBioAvailable
        self.bioLabel.numberOfLines = 3
        
        self.locationImageView.image = UIImage(systemName: ImageConstants.location)
        self.locationImageView.tintColor = .secondaryLabel
    }
    
    func addSubView() {
        self.view.addSubview(avatarImageView)
        self.view.addSubview(userNameLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(locationImageView)
        self.view.addSubview(locationLabel)
        self.view.addSubview(bioLabel)
    }
    
    func layoutUI(){
        let padding:CGFloat = 20
        let textImagePadding:CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //Constraints for the avatar iamge view
            avatarImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            //Constraints for the user name label
            userNameLabel.topAnchor.constraint(equalTo: self.avatarImageView.topAnchor, constant: .zero),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            //Constraints for name label
            nameLabel.centerYAnchor.constraint(equalTo: self.avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //Constraints for location image view
            locationImageView.bottomAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            //Constraints for the locaton label
            locationLabel.centerYAnchor.constraint(equalTo: self.locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: self.locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //Constraints for the bio label
            bioLabel.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor, constant: .zero),
            bioLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
