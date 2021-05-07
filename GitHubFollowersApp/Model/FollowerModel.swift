//
//  FollowerModel.swift
//  GitHubFollowersApp
//
//  Created by Ramnath Sridhar on 07/05/21.
//

import Foundation
public struct FollowerModel : Codable , Hashable{
    var login: String
    var avatar_url: String
}
