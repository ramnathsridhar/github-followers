//
//  BaseUITest.swift
//  GitHubFollowersAppUITests
//
//  Created by Ramnath Sridhar on 09/05/21.
//

import XCTest

class BaseUITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        //Turn off animations while running UI tests
        app.launchArguments.append("UITEST_DISABLE_ANIMATIONS")
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    //The textfield element and the text to be entered is passed
    func typeTextInTextField(textField : XCUIElement,text:String){
        textField.tap()
        textField.clearText()
        textField.typeText(text)
        self.tapKeyBoardSearchButton()
        self.waitToExecuteNextLine(timeOut: 2)
    }
    
    //Search button is tapped on the keypad
    func tapKeyBoardSearchButton(){
        XCUIApplication().keyboards.buttons["search"].tap()
    }
    
    //Wait for a predifned amount of time
    func waitToExecuteNextLine(timeOut:TimeInterval){
        let waitExpectation = expectation(description: "Wait for the specified duration")
        let result = XCTWaiter.wait(for: [waitExpectation], timeout: timeOut)
        if result == XCTWaiter.Result.timedOut{
            XCTAssertTrue(true)
        }else{
           XCTAssertFalse(true)
        }
    }
}

extension XCUIElement{
    //Clears string if text is present in the the element
    func clearText(){
        guard let stringValue = self.value as? String else { return }
        
        var deleteString = String()
        for _ in stringValue{
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        self.typeText(deleteString)
    }
}
