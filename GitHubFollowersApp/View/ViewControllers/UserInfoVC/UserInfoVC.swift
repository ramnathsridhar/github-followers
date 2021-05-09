//
//  UserInfoVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import UIKit

protocol UserInfoVCActionDelegate:class {
    func didTapGithubProfile(for user:UserModel)
    func didTapGetFollowers(for user:UserModel)
}

class UserInfoVC: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = UILabel()
    var itemViews:[UIView] = []
    var userName = String()
    
    weak var delegate:FollowerListVCDelegate!
    public var getUserInfoVM:GetUserInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutUI()
        self.configureViewController()
        self.getUserInfoForUsername()
    }
    
    func getUserInfoForUsername(){
        self.displayLoadingView()
        self.getUserInfoVM?.getGetUserInfo()
    }
    
    func configureViewController(){
        self.view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(dismissUserInfoVC))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureUIElements(with userInfo:UserModel){
        
        self.add(childVC: UserInfoHeaderVC.init(user: userInfo), to: self.headerView)

        
        let repoItemVC = UserRepoItemVC.init(user: userInfo)
                           repoItemVC.delegate = self
                           self.add(childVC: repoItemVC, to: self.itemViewOne)
        
        let followerItemVC = UserFollowerItemVC.init(user: userInfo)
                                 followerItemVC.delegate = self
                                   self.add(childVC: followerItemVC, to: self.itemViewTwo)
        
        self.dateLabel.text = AppMessages.gitHubUserSince + String.space + String.colon + String.space + userInfo.created_at.convertToDisplayFormat()
    }
    
    func layoutUI(){
        self.itemViews = [headerView,itemViewOne,itemViewTwo,dateLabel]
        let padding : CGFloat = 20

        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant:  -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 40),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: self.itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: self.itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        dateLabel.textAlignment = .center
    }
    
    func add(childVC:UIViewController,to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissUserInfoVC(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension UserInfoVC:GetUserInfoFlowDelegate{
    func getUserInfoSuccessful(userInfo: UserModel) {
        self.dismissLoadingView()
        DispatchQueue.main.async {
            self.configureUIElements(with: userInfo)
        }
    }
    
    func getUserInfoFailed(errorMessage: String) {
        self.dismissLoadingView()
        self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: errorMessage, buttonTitle: AppMessages.okString)
    }
}

extension UserInfoVC:UserInfoVCActionDelegate{
    func didTapGithubProfile(for user: UserModel) {
        guard let url = URL(string: user.html_url) else {
            self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: ErrorMessages.userProfileURLInvalid.rawValue, buttonTitle: AppMessages.okString)
            return
        }
        self.presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: UserModel) {
        guard user.followers != 0 else {
            self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: ErrorMessages.userHasNoFollowers.rawValue, buttonTitle: AppMessages.okString)
            return
        }
        self.delegate.didRequestFollowers(for: user.login)
        self.dismissUserInfoVC()
        return
    }
}
