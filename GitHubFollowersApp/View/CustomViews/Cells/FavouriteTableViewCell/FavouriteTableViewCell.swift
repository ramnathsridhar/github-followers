//
//  FavouriteTableViewCell.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var userLogoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    static let reuseID = "favouriteTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUserDetails(userName:String,userImageURL:String){
        self.userNameLabel.text = userName
        self.userLogoImageView.downloadImage(from: userImageURL)
        self.userLogoImageView.clipsToBounds = true
        self.userLogoImageView.layer.cornerRadius = 10
    }
}
