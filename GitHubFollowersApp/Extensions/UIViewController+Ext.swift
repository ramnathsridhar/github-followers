//
//  UIViewController+Ext.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import UIKit
import SafariServices

fileprivate var containerView:UIView!

extension UIViewController{
    //To display popup
    func displayAlertPopup(alertTitle:String,alertMessage:String,buttonTitle:String,actionOnClickOfOk:((UIAlertAction) -> Void)? = nil){
        //Create the alert
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle:.alert)
        //Add action to alert
        alert.addAction(UIAlertAction.init(title: buttonTitle, style: .default, handler: actionOnClickOfOk))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Display loading view on screen
    func displayLoadingView(){
        containerView = UIView.init(frame: self.view.frame)
        self.view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
        
    //Dismiss the loading view on screen
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
