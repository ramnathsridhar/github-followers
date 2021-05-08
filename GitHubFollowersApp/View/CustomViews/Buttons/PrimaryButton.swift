//
//  PrimaryButton.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Custom code
        self.configure()
    }
    
    //Required when initalising elements which might have storyboard component like button
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColour:UIColor, title:String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColour
        self.setTitle(title, for: .normal)
        self.configure()
    }
    
    private func configure(){
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColour:UIColor,title:String){
        self.backgroundColor = backgroundColour
        self.setTitle(title, for: .normal)
    }
    
}
