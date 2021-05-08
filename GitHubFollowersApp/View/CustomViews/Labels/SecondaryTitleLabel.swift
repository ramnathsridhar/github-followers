//
//  SecondaryTitleLabel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class SecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(sizeOfFont:CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: sizeOfFont, weight: .medium)
        self.configure()
    }
    
    private func configure(){
        self.textColor = .secondaryLabel
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.90
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
