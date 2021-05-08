//
//  FollowerCollectionViewCell.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var followerCellImageView: UserAvatarImageView!
    @IBOutlet weak var followerCellNameLabel: UILabel!
    
    static let reuseID = "followerCollectionViewCell"
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.followerCellImageView.image = UIImage.init(named: ImageConstants.placeHolderImage)
    }
    
    func setFollowerDetails(follower:FollowerModel){
        self.followerCellImageView.downloadImage(from: follower.avatar_url)
        self.followerCellImageView.layer.cornerRadius = 10

        self.followerCellNameLabel.text = follower.login
        
        self.followerCellNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.followerCellNameLabel.adjustsFontSizeToFitWidth = true
        self.followerCellNameLabel.textColor = .black
        self.followerCellNameLabel.lineBreakMode = .byTruncatingTail
        self.followerCellNameLabel.minimumScaleFactor = 0.9
                
        self.layer.cornerRadius = 10
        self.backgroundColor = .secondarySystemBackground
    }
    
    public override func prepareForReuse() {
        self.followerCellImageView.image = UIImage.init(named: ImageConstants.placeHolderImage)
    }    
}
