//
//  AppDelegate.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Disable animations if the UI tests are being run
        if CommandLine.arguments.contains("UITEST_DISABLE_ANIMATIONS"){
            UIView.setAnimationsEnabled(false)
        }
        return true
    }
}
