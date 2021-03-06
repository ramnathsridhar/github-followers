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
        self.userNameTextField.delegate = self
        self.setupUI()
        self.dismissKeybordFunction()
        self.setAccessibilityIdentifiers()
    }
    
    func setAccessibilityIdentifiers(){
        self.userNameTextField.accessibilityIdentifier = AccessibilityIdentifers.userNameTextField
        self.searchButton.accessibilityIdentifier = AccessibilityIdentifers.searchButton
    }

    //Code to modify UI properties to elements on screen
    func setupUI(){
        self.searchButton.layer.cornerRadius = 10
        self.searchButton.backgroundColor = .black
        self.searchButton.setTitleColor(.white, for: .normal)
        self.logoImageView.layer.cornerRadius = 10
        self.userNameTextField.returnKeyType = .search
        self.userNameTextField.layer.borderColor = UIColor.black.cgColor
        self.userNameTextField.layer.cornerRadius = 10
        self.userNameTextField.layer.borderWidth = 1
        self.userNameTextField.autocorrectionType = .no
        //Animation
        self.animateUI()
    }
    
    func animateUI(){
        //Setting the alpha of the textfield and submit button to 0
        //To give the effect that the logo present in launch screen is moving up
        self.userNameTextField.alpha = 0
        self.searchButton.alpha = 0
        //The animations take place over a duration of 1.5 seconds
        UIView.animate(withDuration: 1.5) {
            //The username textfield and search button become visible
            self.userNameTextField.alpha = 1
            self.searchButton.alpha = 1
            //The elements on screen move up by 50
            self.logoImageView.frame.origin.y -= 50
            self.userNameTextField.frame.origin.y -= 50
            self.searchButton.frame.origin.y -= 50
        }
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
