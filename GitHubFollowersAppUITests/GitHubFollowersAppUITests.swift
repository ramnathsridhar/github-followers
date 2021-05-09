//
//  GitHubFollowersAppUITests.swift
//  GitHubFollowersAppUITests
//
//  Created by Ramnath Sridhar on 06/05/21.
//

import XCTest
@testable import GitHubFollowersApp

class GitHubFollowersAppUITests: BaseUITest {

    func testInvalidUserNameEntered(){
        let app = XCUIApplication()
        let enterUsernameHereTextField = app.textFields["userNameTextField"]
        typeTextInTextField(textField: enterUsernameHereTextField, text: "")
        XCTAssert(app.alerts["Error"].exists)
    }
    
    func testValidUserNameEntered(){
        let app = XCUIApplication()
        let enterUsernameHereTextField = app.textFields["userNameTextField"]
        typeTextInTextField(textField: enterUsernameHereTextField, text: "sam")
        XCTAssert(app.staticTexts["sam"].exists)
    }
    
    func testGetUserInfoForValidUser(){
        let app = XCUIApplication()
        let enterUsernameHereTextField = app.textFields["userNameTextField"]
        typeTextInTextField(textField: enterUsernameHereTextField, text: "sam")
        
        let firstElementOfFollowersCollectionVIew = app.collectionViews.children(matching: .any).element(boundBy: 0)
        if firstElementOfFollowersCollectionVIew.exists {
            firstElementOfFollowersCollectionVIew.tap()
        }
        waitToExecuteNextLine(timeOut: 5)
        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["Git Profile"]/*[[".buttons[\"Git Profile\"].staticTexts[\"Git Profile\"]",".staticTexts[\"Git Profile\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }
}
