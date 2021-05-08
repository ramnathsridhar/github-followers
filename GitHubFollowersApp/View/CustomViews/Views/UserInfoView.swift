//
//  UserInfoView.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

enum UserInfoType {
        case repos , gists , followers , following
}

class UserInfoView: UIView {

        let symbolImageView = UIImageView()
        let titleLabel = TitleLabel.init(textAlignment: .center, fontSize: 14)
        let countTitleLabel = TitleLabel.init(textAlignment: .center, fontSize: 14)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configure(){
            self.addSubview(symbolImageView)
            self.addSubview(titleLabel)
            self.addSubview(countTitleLabel)
            
            self.symbolImageView.translatesAutoresizingMaskIntoConstraints = false
            self.symbolImageView.contentMode = .scaleAspectFill
            self.symbolImageView.tintColor = .label
            
            
            NSLayoutConstraint.activate([
                self.symbolImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: .zero),
                self.symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .zero),
                self.symbolImageView.widthAnchor.constraint(equalToConstant: 20),
                self.symbolImageView.heightAnchor.constraint(equalToConstant: 20),
                
                self.titleLabel.centerYAnchor.constraint(equalTo: self.symbolImageView.centerYAnchor, constant: 0),
                self.titleLabel.leadingAnchor.constraint(equalTo: self.symbolImageView.trailingAnchor, constant: 12),
                self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                self.titleLabel.heightAnchor.constraint(equalToConstant: 18),
                
                self.countTitleLabel.topAnchor.constraint(equalTo: self.symbolImageView.bottomAnchor, constant: 4),
                self.countTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                self.countTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
                self.countTitleLabel.heightAnchor.constraint(equalToConstant: 18)
            ])
        }
        
        func set(userInfoType:UserInfoType, with count:Int){
            switch userInfoType {
            case .repos:
                self.symbolImageView.image = UIImage(systemName: AppSymbols.repos)
                self.titleLabel.text = "Public Repos"
            case .followers:
                self.symbolImageView.image = UIImage(systemName: AppSymbols.followers)
                self.titleLabel.text = "Followers"
            case .following:
                self.symbolImageView.image = UIImage(systemName: AppSymbols.following)
                self.titleLabel.text = "Following"
            case .gists:
                self.symbolImageView.image = UIImage(systemName: AppSymbols.gists)
                self.titleLabel.text = "Public Gists"
            }
            self.countTitleLabel.text = String(count)
        }
    }
