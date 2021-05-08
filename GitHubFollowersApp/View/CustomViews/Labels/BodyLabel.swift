//
//  BodyLabel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class BodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment:NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.configure()
    }
    
    private func configure(){
        self.textColor = .secondaryLabel
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.75
        self.lineBreakMode = .byWordWrapping
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

