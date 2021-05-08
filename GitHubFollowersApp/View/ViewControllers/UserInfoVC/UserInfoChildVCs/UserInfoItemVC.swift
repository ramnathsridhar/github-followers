//
//  UserInfoItemVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

class UserInfoItemVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = UserInfoView()
    let itemInfoViewTwo = UserInfoView()
    let actionButton = PrimaryButton()

    var user:UserModel!
    weak var delegate:UserInfoVCActionDelegate!
    
    init(user:UserModel) {
        super.init(nibName:nil,bundle:nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackgroundView()
        self.layoutUI()
        self.configureStackView()
        self.configureActionButtonTapped()
    }
    
    private func configureActionButtonTapped(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped(){}
    
    private func configureBackgroundView(){
        self.view.layer.cornerRadius = 18
        self.view.backgroundColor = .secondarySystemBackground
    }
    
    private func layoutUI(){
        self.view.addSubview(stackView)
        self.view.addSubview(actionButton)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.stackView.heightAnchor.constraint(equalToConstant: 50),
            
            self.actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant:-padding),
            self.actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            self.actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            self.actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureStackView(){
        self.stackView.axis = .horizontal
        self.stackView.distribution = .equalSpacing
        self.stackView.addArrangedSubview(self.itemInfoViewOne)
        self.stackView.addArrangedSubview(self.itemInfoViewTwo)
    }
    
}
