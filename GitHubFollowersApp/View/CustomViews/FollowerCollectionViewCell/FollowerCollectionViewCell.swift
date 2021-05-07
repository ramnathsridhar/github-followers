//
//  FollowerCollectionViewCell.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var followerCellImageView: UIImageView!
    @IBOutlet weak var followerCellNameLabel: UILabel!
    
    static let reuseID = "followerCollectionViewCell"
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.followerCellImageView.image = UIImage.init(named: "avatar-placeholder")
    }
    
    func setFollowerDetails(follower:FollowerModel){
        self.followerCellImageView.downloadImage(from: follower.avatar_url)
        self.followerCellNameLabel.text = follower.login
        
        self.followerCellNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        self.followerCellNameLabel.adjustsFontSizeToFitWidth = true
        self.followerCellNameLabel.textColor = .white
        self.followerCellNameLabel.lineBreakMode = .byTruncatingTail
        self.followerCellNameLabel.minimumScaleFactor = 0.9
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .black
    }
    
    public override func prepareForReuse() {
        self.followerCellImageView.image = UIImage.init(named: "avatar-placeholder")
    }
    

}
