//
//  UserModel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 08/05/21.
//

import Foundation
struct UserModel:Codable {
    var login: String
    var avatar_url: String
    var name: String?
    var location: String?
    var bio: String?
    var public_repos: Int
    var public_gists: Int
    var html_url: String
    var followers: Int
    var following: Int
    var created_at: String
}
