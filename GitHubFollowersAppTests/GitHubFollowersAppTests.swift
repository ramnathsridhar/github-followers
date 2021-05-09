//
//  GitHubFollowersAppTests.swift
//  GitHubFollowersAppTests
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import XCTest
@testable import GitHubFollowersApp

class GitHubFollowersAppTests: BaseUnitTest {

    func testValidateEmptyUserName(){
        let searchUsernameVM = SearchUserNameViewModel.init(delegate: nil)
        searchUsernameVM.enteredUsername = String.empty
         XCTAssertFalse(searchUsernameVM.validateUserName())
    }
    
    func testValidateValidUserName(){
        let searchUsernameVM = SearchUserNameViewModel.init(delegate: nil)
        searchUsernameVM.enteredUsername = "NotEmpty"
         XCTAssert(searchUsernameVM.validateUserName())
    }
}
