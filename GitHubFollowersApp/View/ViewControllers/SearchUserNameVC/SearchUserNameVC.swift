//
//  SearchUserNameVC.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import UIKit

class SearchUserNameVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var searchButton: PrimaryButton!
    
    var userNameViewModel:SearchUserNameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.dismissKeybordFunction()
    }

    //Code to modify UI properties to elements on screen
    func setupUI(){
        self.searchButton.layer.cornerRadius = 10
        self.searchButton.backgroundColor = .black
        self.searchButton.setTitleColor(.white, for: .normal)
        self.logoImageView.layer.cornerRadius = 10
        self.userNameTextField.returnKeyType = .search
    }
    
    //Function to dismiss keyboard
    func dismissKeybordFunction(){
        let keyBoardDismissTapGesture = UITapGestureRecognizer.init(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(keyBoardDismissTapGesture)
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        self.userNameViewModel?.enteredUsername = self.userNameTextField.text ?? String.empty
        self.userNameViewModel?.getFollowersForUser()
    }
}

//Extension to implement the viewmodel delegate methods
extension SearchUserNameVC:SearchUserNameFlowDelegate{
    func getUserNameFollowersSuccessful() {
        let followersListVC = FollowersListVC.init()
        followersListVC.title = self.userNameViewModel?.enteredUsername ?? String.empty
        followersListVC.followersListVM = FollowersListViewModel.init(delegate: followersListVC, userName: self.userNameViewModel?.enteredUsername ?? String.empty)
        self.navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    func getUserNameFollowersFailed(errorMessage: String) {
        self.displayAlertPopup(alertTitle: ErrorMessages.errorString.rawValue, alertMessage: errorMessage, buttonTitle: AppMessages.okString)
        return
    }
}

//Extension to handle tap on return button in keypad
extension SearchUserNameVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userNameViewModel?.enteredUsername = self.userNameTextField.text ?? String.empty
        self.userNameViewModel?.getFollowersForUser()
        return true
    }
}
